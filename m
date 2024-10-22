Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6213B5B7;
	Tue, 22 Oct 2024 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567277; cv=pass; b=jABZ2PUbfucoAIxcP4WJopuPjokgcGICgoLpWXqlZf5IWuU3XfriHgIl6e8+Pr+zZ7LauMpvlXTmp31B16qhkSv+1jGmCOWy4LjXyKfMkiyDK85vyi5SdaUvj+s/YXZd/ebAxhisyqmPPsu5CYlDPEibx2mBG/MNXs86rlX7Wrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567277; c=relaxed/simple;
	bh=ZFZfYC/XXlhzEGIBsCfpGwi2AGcTgaqrdpCXupX8wmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OP/0hIeiLN17SJoaZryBGV6ncSLxxghVhR8dg3EqzgdJv8JkIP341TRQ1iemCsvJOUi3IgPbbWUyc+8r/Uw/vQ6p8O4cZdnJoMmJxfHPYLVLAWie26Ulctsf2vf+pp/sVGbwG5ffVXApjzTvSRPrmVNUouZaoZDylAcLJmnEPJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=GB3p+UWw; arc=pass smtp.client-ip=23.83.212.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="GB3p+UWw"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6CAC02C2C6F;
	Tue, 22 Oct 2024 03:21:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a259.dreamhost.com (100-99-188-116.trex-nlb.outbound.svc.cluster.local [100.99.188.116])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D70A52C2D4B;
	Tue, 22 Oct 2024 03:21:13 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729567274; a=rsa-sha256;
	cv=none;
	b=d3ITU+jB2QskEFg/4SaF4XSRIv7xTZgr1jbEAm1wVhdwlCcdnRHDGhfgl7+HyvKXdfolbJ
	B0nMdbrbSsF84MaH7/IcOO+HUjsPM66nB05DfnycxNxayDDZHhOrg5Di7rgEUBlXQCd25C
	/RBk7RF3k3CaitAKUWdKZsyqQRReRVxUek+nL4QEOa+zJjc2XNkGHaH5z3PGZ8f5HQ5buT
	IiCkspZ8WWL9ejL7FzWjL2IbrftnM48JjkFSegdN0uHi5p7OP1fuRsFyEANq/4YlmV2fKA
	NQXqE4qK7je+pdt2O/c/4Pg3u9zdVyW+KvfhzoWlJVbxbgD7aZqexfO0bVq3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729567274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=68EwBF3cXE1JHXLb2ovYMt6cAN5GFh2afO+CWcHSCgw=;
	b=4Kd8MJKJAiVgiyypr86ZU4IUQ8H9V6MBbAQxR2eVfIJcapb8R39/khdliM1OqEU3hlLicV
	svFma8x2A8dzvUtlJgjAhtap52IHkG6k0qEWi/BWP2sExb3aDFCM8Y/i3aWpkfEf8R2hUG
	aV3ZDPmkTCSlI7GzEFENFTauSvAAYRXZ4+vltif9c0XCXDVhPX/EsZGBlFjbZCwXQ3VS4y
	L0Pg9wsOvCllmLF1N8lBdBKXEjehqbD2ipM32AFPe5EPzaMDslsVJYUoeOalMgdEv0ZUy+
	JmsG3VnApS3ZM9y5h7+Xa0n75efM/QBDj/GmmtVPg1wum62iObmgekRRMuCc/w==
ARC-Authentication-Results: i=1;
	rspamd-75d86777c9-mm5qb;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cure-Eyes: 295dd4665ea49200_1729567274226_2911567491
X-MC-Loop-Signature: 1729567274226:1604051089
X-MC-Ingress-Time: 1729567274226
Received: from pdx1-sub0-mail-a259.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.188.116 (trex/7.0.2);
	Tue, 22 Oct 2024 03:21:14 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a259.dreamhost.com (Postfix) with ESMTPSA id 4XXcs44nfwz9g;
	Mon, 21 Oct 2024 20:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1729567273;
	bh=68EwBF3cXE1JHXLb2ovYMt6cAN5GFh2afO+CWcHSCgw=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=GB3p+UWw8xVZQmbSIXTZ9wIEvkJz8sYuEIEI+iFn0VUAFMBvopm4fVAEXOVIL4Emr
	 /wIkdESR5HF0POS3U3ib9nmGRD+m1zaRN71IlrhjKFpdW7tSdRLu6U6tlsBghmWgmV
	 K9RbiqyMpawnw0l9ASHzhoKoH/ieofCDYJMIt3qLgUsIuYpcfPfhV4kJ9uI7dEFfh/
	 D5yeZ8fN6ijKGtur0TRSzIXjooMIylbZupYCMyTQ9DYhXPcTnQwiUXAuIKu1Ca0J4f
	 ZnIuRQ5raEEzoMQMfxouTTmCEsVIzLl9DOwuttsrvYHht5626ErN/pXoq/MSed6Xh5
	 p8S9wL68m2HAg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dan.j.williams@intel.com,
	dave.jiang@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	fan.ni@samsung.com,
	a.manzanares@samsung.com,
	sthanneeru.opensrc@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	Ravis.OpenSrc@micron.com,
	sthanneeru@micron.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] cxl/mbox: support background operation abort requests
Date: Mon, 21 Oct 2024 20:18:06 -0700
Message-ID: <20241022031809.242591-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series implements the abortable capabilities for mailbox background
operations, introduced in CXL 3.1.

Details in each patch, but patch 1 moves non-sanitize background command
polling out of the mbox_mutex, such that patch 2 can add the machinery
to request aborting the on going command. Patch 3 simply renames a call.

While an overal policy could include command-priorities (which could
be trivially added); the current policy is that, if there is an on going
background operation, a new incoming bg-capable command will blindly
request it to be cancelled, if capable.

Considering the interest of this for Logs[0], perhaps Micron folks could
this? Does this work along the lines of what that discussion concluded?

Applies against Linus' latest tree.

[0]: https://lore.kernel.org/all/20240313071218.729-1-sthanneeru.opensrc@micron.com/

Testing:

lockdep enabled kernel + the qemu counterpart patches:
	https://lore.kernel.org/linux-cxl/20240813221255.179200-1-dave@stgolabs.net/

#> echo 1 > /sys/bus/cxl/devices/mem1/security/sanitize && sleep 3 && echo 1 > /sys/bus/cxl/devices/mem1/security/sanitize
[  185.928276] cxl_pci:__cxl_pci_mbox_send_cmd:262: cxl_pci 0000:0d:00.0: Sending command: 0x4400cxl/devices/mem1/security/sanitize
[  185.930024] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
[  185.931608] cxl_pci:__cxl_pci_mbox_send_cmd:306: cxl_pci 0000:0d:00.0: Sanitization operation started
[  188.936583] cxl_pci:__cxl_pci_mbox_send_cmd:262: cxl_pci 0000:0d:00.0: Sending command: 0x0005
[  188.943956] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
[  188.951786] cxl_pci:cxl_try_to_cancel_background:376: cxl_pci 0000:0d:00.0: Sanitization operation aborted
[  188.957762] cxl_pci:__cxl_pci_mbox_send_cmd:262: cxl_pci 0000:0d:00.0: Sending command: 0x4400
[  188.959886] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0d:00.0: Doorbell wait took 0ms
[  188.962325] cxl_pci:__cxl_pci_mbox_send_cmd:306: cxl_pci 0000:0d:00.0: Sanitization operation started
[  197.034644] cxl_pci:cxl_mbox_sanitize_work:164: cxl_pci 0000:0d:00.0: Sanitization operation ended

#> cxl update-firmware -F img.fw mem1 && sleep 3 && echo 1 > /sys/bus/cxl/devices/mem1/security/sanitize
[   14.443484] cxl_pci:__cxl_pci_mbox_send_cmd:262: cxl_pci 0000:0e:00.0: Sending command: 0x0200
[   14.445884] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0e:00.0: Doorbell wait took 0ms
[   14.448744] cxl_core:cxl_query_cmd:539: cxl_mem mem1: Query IOCTL
[   14.450458] cxl_core:cxl_query_cmd:539: cxl_mem mem1: Query IOCTL
[   14.452307] cxl_core:cxl_send_cmd:644: cxl_mem mem1: Send IOCTL
[   14.453686] cxl_core:handle_mailbox_cmd_from_user:602: cxl_pci 0000:0e:00.0: Submitting Get FW Info command for user
[   14.453686] 	opcode: 200
[   14.453686] 	size: 0
[   14.460453] cxl_pci:__cxl_pci_mbox_send_cmd:262: cxl_pci 0000:0e:00.0: Sending command: 0x0201
[   14.462313] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0e:00.0: Doorbell wait took 0ms
[   14.464166] cxl_pci:__cxl_pci_mbox_send_cmd:310: cxl_pci 0000:0e:00.0: Mailbox background operation (0x0201) started
[   14.466536] cxl_pci:__cxl_pci_mbox_send_cmd:262: cxl_pci 0000:0e:00.0: Sending command: 0x0200
[   14.468380] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0e:00.0: Doorbell wait took 0ms
{
  "memdev":"mem1",
  "pmem_size":"1024.00 MiB (1073.74 MB)",
  "serial":"0",
  "host":"0000:0e:00.0",
  "firmware":{
    "num_slots":2,
    "active_slot":1,
    "online_activate_capable":true,
    "slot_1_version":"BWFW VERSION 0",
    "fw_update_in_progress":true,
    "remaining_size":"48.83 MiB (51.20 MB)"
  }
}
cxl memdev: cmd_update_fw: firmware update started on 1 mem device
[   17.484680] cxl_pci:__cxl_pci_mbox_send_cmd:262: cxl_pci 0000:0e:00.0: Sending command: 0x0005
[   17.486993] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0e:00.0: Doorbell wait took 0ms
[   17.489510] cxl_pci:cxl_pci_mbox_send:451: cxl_pci 0000:0e:00.0: Mailbox background operation (0x0201) aborted
[   17.492476] cxl_pci:__cxl_pci_mbox_send_cmd:262: cxl_pci 0000:0e:00.0: Sending command: 0x4400
[   17.494937] cxl_pci:cxl_pci_mbox_wait_for_doorbell:74: cxl_pci 0000:0e:00.0: Doorbell wait took 0ms
[   17.497598] cxl_pci:__cxl_pci_mbox_send_cmd:306: cxl_pci 0000:0e:00.0: Sanitization operation started
[   25.682631] cxl_pci:cxl_mbox_sanitize_work:164: cxl_pci 0000:0e:00.0: Sanitization operation ended

Thanks!

Davidlohr Bueso (3):
  cxl/pci: lockless background synchronous polling
  cxl/mbox: support aborting the current background operation
  cxl/pci: rename cxl_mbox_background_complete()

 drivers/cxl/core/mbox.c |   1 +
 drivers/cxl/cxlmem.h    |  14 +++
 drivers/cxl/pci.c       | 189 ++++++++++++++++++++++++++++------------
 include/cxl/mailbox.h   |   2 +
 4 files changed, 152 insertions(+), 54 deletions(-)

--
2.46.1

