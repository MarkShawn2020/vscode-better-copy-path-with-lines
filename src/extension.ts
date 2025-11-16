import * as vscode from 'vscode';
import { DoCopy, CopyCommandType } from './facade';

export function activate(context: vscode.ExtensionContext) {
	const relativePathWithLine = vscode.commands.registerCommand('markshawn2020.copy.relative.path.line', (uri) => {
		DoCopy(CopyCommandType.CopyRelativePathWithLine, uri);
	});

	const absolutePathWithLine = vscode.commands.registerCommand('markshawn2020.copy.absolute.path.line', (uri) => {
		DoCopy(CopyCommandType.CopyAbsolutePathWithLine, uri);
	});

	context.subscriptions.push(relativePathWithLine, absolutePathWithLine);
}

export function deactivate() { }
