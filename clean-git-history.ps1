Write-Host "🧹 Cleaning Git history of sensitive information..."

# Create a backup branch
git checkout -b backup-before-clean

# Create a new branch without the history
git checkout --orphan temp-clean-branch

# Add all files
git add .

# Commit the current state
git commit -m "Initial commit with clean history"

# Delete the main branch
git branch -D main

# Rename the current branch to main
git branch -m main

# Force push to remote
$response = Read-Host "⚠️  The following command will force push to remote. Are you sure? (y/n)"
if ($response -match '^[yY](es)?$') {
    git push -f origin main
    Write-Host "✅ Git history has been cleaned"
} else {
    Write-Host "❌ Operation cancelled"
    exit 1
}

# Clean up
git branch -D backup-before-clean
git gc --aggressive --prune=all

Write-Host "🎉 Git history cleaning completed!" 