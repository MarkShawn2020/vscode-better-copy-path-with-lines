import * as vscode from 'vscode';
import { DoCopy, CopyCommandType } from './facade';

require('source-map-support').install();

export function activate(context: vscode.ExtensionContext) {
	const relativePathWithLine = vscode.commands.registerCommand('qishan233.copy.relative.path.line', (uri) => {
		DoCopy(CopyCommandType.CopyRelativePathWithLine, uri);
	});

	const absolutePathWithLine = vscode.commands.registerCommand('qishan233.copy.absolute.path.line', (uri) => {
		DoCopy(CopyCommandType.CopyAbsolutePathWithLine, uri);
	});

	context.subscriptions.push(relativePathWithLine, absolutePathWithLine);
}

export function deactivate() { }
