Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AB0143890
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 07:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890003; cv=none; b=SFcL/ru700mCYTB1TbhUJxiJNfPXOoKv+hJ271tcGr74FBC5lTelADcIe1Zf/5qQpbe128TlLKhOb2nHku+f2yG/BmzS1Q6pOUCdCutBr7NjiVjWT7uSxgTjy6UdDmD/s2w36mInhKV+a5kIESlcoNhxG50jc0h+ewMhtQ/r/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890003; c=relaxed/simple;
	bh=L+kmUmBZyE1JxaP/ukKcr0nt/7wiRTvQAcw9WY/VMuA=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=skJcf8EekHNVEPDOTZ72yGroU9zlw5KFtCZJF0edvSp0GF2LsFyW48UrfB9PrYfOJYHCoDzpddLDtMNRO11KsyKTzQ13hw+kRlR23if7IPkLMxicWOD12fPwroEregUNjH9IxDlpvMhTHL1J9hsAcH/BGR2B0aW1zz6PRHzdzII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LRrC1RxU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8185IeLE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LRrC1RxU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8185IeLE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LRrC1RxU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8185IeLE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LRrC1RxU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8185IeLE"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 431082209F
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 07:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728889999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L+kmUmBZyE1JxaP/ukKcr0nt/7wiRTvQAcw9WY/VMuA=;
	b=LRrC1RxUqXYySBREYBEF0Cpr6F7Drg17QPtouZ4UY3shrmBXFzG8sUmGInvkz6x9tgwfpx
	orkn3zAF8bDxeBuyXEWCfSI2mt6cLAZflMJD74fqJGdvTJUU7/QUSJI84phHSD8fu7vUqU
	25CRDHhcMXfBO+8wIUguIi1nWVahewE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728889999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L+kmUmBZyE1JxaP/ukKcr0nt/7wiRTvQAcw9WY/VMuA=;
	b=8185IeLEdfTt+qhIndg0TRKTsNIuog3NSJXVf1fKRf857vfHanPN8U7stTK/9SYFoW9ril
	pN8kaGOzv89RvxCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LRrC1RxU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8185IeLE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728889999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L+kmUmBZyE1JxaP/ukKcr0nt/7wiRTvQAcw9WY/VMuA=;
	b=LRrC1RxUqXYySBREYBEF0Cpr6F7Drg17QPtouZ4UY3shrmBXFzG8sUmGInvkz6x9tgwfpx
	orkn3zAF8bDxeBuyXEWCfSI2mt6cLAZflMJD74fqJGdvTJUU7/QUSJI84phHSD8fu7vUqU
	25CRDHhcMXfBO+8wIUguIi1nWVahewE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728889999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L+kmUmBZyE1JxaP/ukKcr0nt/7wiRTvQAcw9WY/VMuA=;
	b=8185IeLEdfTt+qhIndg0TRKTsNIuog3NSJXVf1fKRf857vfHanPN8U7stTK/9SYFoW9ril
	pN8kaGOzv89RvxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFE6313A42
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 07:13:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /cn7Go7EDGcxWQAAD6G6ig
	(envelope-from <colyli@suse.de>)
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 07:13:18 +0000
From: Coly Li <colyli@suse.de>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Removing a misleading warning message? 
Message-Id: <59EA939D-03E1-40FC-88D2-BCFA4DE5A436@suse.de>
Date: Mon, 14 Oct 2024 15:12:59 +0800
To: linux-cxl@vger.kernel.org
X-Mailer: Apple Mail (2.3776.700.51)
X-Rspamd-Queue-Id: 431082209F
X-Spam-Score: -2.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.21 / 50.00];
	BAYES_HAM(-2.20)[96.20%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-cxl@vger.kernel.org];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi list,

Recently I have a report for a warning message from CXL subsystem,
[ 48.142342] cxl_port port2: Couldn't locate the CXL.cache and CXL.mem =
capability array header.
[ 48.144690] cxl_port port3: Couldn't locate the CXL.cache and CXL.mem =
capability array header.
[ 48.144704] cxl_port port3: HDM decoder capability not found
[ 48.144850] cxl_port port4: Couldn't locate the CXL.cache and CXL.mem =
capability array header.
[ 48.144859] cxl_port port4: HDM decoder capability not found
[ 48.170374] cxl_port port6: Couldn't locate the CXL.cache and CXL.mem =
capability array header.
[ 48.172893] cxl_port port7: Couldn't locate the CXL.cache and CXL.mem =
capability array header.
[ 48.174689] cxl_port port7: HDM decoder capability not found
[ 48.175091] cxl_port port8: Couldn't locate the CXL.cache and CXL.mem =
capability array header.
[ 48.175105] cxl_port port8: HDM decoder capability not found

After checking the source code I realize this is not a real bug, just a =
warning message that expected device was not detected.
But from the above warning information itself, users/customers are =
worried there is something wrong (IMHO indeed not).

Is there any chance that we can improve the code logic that only =
printing out the warning message when it is really a problem to be =
noticed?=20

Thanks in advance.

Coly Li=
