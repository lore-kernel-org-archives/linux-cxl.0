Received: from heron.birch.relay.mailchannels.net (heron.birch.relay.mailchannels.net [23.83.209.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EBE13AE3
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="nkB3CP51"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CD9AD54169E;
	Tue,  9 Jan 2024 07:04:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4CDC8541AEE;
	Tue,  9 Jan 2024 07:04:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1704783897; a=rsa-sha256;
	cv=none;
	b=SsT5t232W37gljyGCDVjuoKlsCw1nxOiZGcxQC3WIWDuiJZcX3JPBZeHpxqMNafpKPv5vv
	EDNKbI9/Ae8lzJ2tznVbmSaXhaqHcF76U2stEGSLc8VuuEVr8UKb3qBh6bTu9E3ZqV4Lr3
	J5RaFu4NWBcbjRNsGRWp3zVSdXsvXXqGy/LSrYu2en1iz2nOl1q9Z4dzYEUZsNu0P9t/Yk
	49AzIr9szUZTRODE/oRON27zYyLdsfBS6pZeeqXheRgPQQRta+12b0G6xzj75+ATRgzgKQ
	sWDJQjSJjQqRxjc8OoTOCAUdSCb2hK/58XR4WpPyJgDQhaQn9iX6yP49ALanhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1704783897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=V2Lhr+DTUjD5nQ/CtWo/FzXuHZ8vC95BuWG1lX2fnIo=;
	b=1U3rGKpNKQigTY38SYESBujLPv+YWJtRZ1nH0xhGGGa4w1mNHQRWPZ8CHe+Bunz0WzCXqx
	NREPLnqPXdQzMN9Yk/IdCYdNphnFkLOo7pSq0xEoMaZKFc/4MRf/YV+2wncoiN9N83TlBz
	BBX8e9EEOhE0c9FZEB1GWjU0V4RSok6rs6dfOlux/3d7n2LsZPEzCAk1PtwKOgWzZnirrV
	q+QDd3jBix73fBff8T+cKp79NsGr8/kZTtrof2+XjGaqWFhABL9QcXAhc1fYqROQYbGX+s
	4fTwtVF3egs91vYtbRPohKzOU+OZ+kqKfS05ogdDQiOmGga0M9+tXlif3ibwgw==
ARC-Authentication-Results: i=1;
	rspamd-69494b7fd5-fs7ld;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Invention-Lonely: 69350bfc7ced50dd_1704783897587_535705680
X-MC-Loop-Signature: 1704783897587:3715578132
X-MC-Ingress-Time: 1704783897587
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.134.10 (trex/6.9.2);
	Tue, 09 Jan 2024 07:04:57 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4T8MPh4y9Gz2b;
	Mon,  8 Jan 2024 23:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1704783897;
	bh=V2Lhr+DTUjD5nQ/CtWo/FzXuHZ8vC95BuWG1lX2fnIo=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=nkB3CP51MZN/5OK0mCgqy0lFIzKMCpLvvDJhzNkW6fEyzKEPJjGpCsjbWMw6QKNgD
	 A8Pq+ix77U1TSrTgIALQ3vZyJxkgrU0T3Xx7Bn/srRwv4Ubmwx+VaCxaQ4XpATOO3K
	 SNNV0Vlg0/kv5fSS//+o6RFe9mRc7ZqyTIQmNg0wyw2tdPUag5XwlBFdLX2DFvNjr3
	 qC6EnY2TPUMAvdVob87mFCHjFmetOVf1nXu8xJvcbm/M3SQn+BoHvVLkdSXvo7PGm2
	 ub/oL69dwL9kn8WSlLtbVVGpyJ37S66SE7q4xn5/mXMdTYyvF9oOdq8tXEqH/aJ3e9
	 oOsOrKHyDij5g==
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan.Cameron@huawei.com
Cc: vishal.l.verma@intel.com,
	fan.ni@samsung.com,
	a.manzanares@samsung.com,
	mounika.k@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH -qemu 0/2] hw/cxl: Firmware Update support
Date: Mon,  8 Jan 2024 23:04:34 -0800
Message-ID: <20240109070436.21253-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The following implements the remaining commands for emulating the cxl
firmware update operations, similar to what the mock device does.

# cxl update-firmware mem0 
  ...
  "firmware":{
    "num_slots":2,
    "active_slot":1,
    "staged_slot":1,
    "online_activate_capable":true,
    "slot_1_version":"BWFW VERSION 0",
    "fw_update_in_progress":false
  }
}

# cxl update-firmware mem0 -F ~/fw.bin -w
{
  ...
  "firmware":{
    "num_slots":2,
    "active_slot":1,
    "staged_slot":2,
    "online_activate_capable":true,
    "slot_1_version":"BWFW VERSION 0",
    "slot_2_version":"BWFW VERSION 1",
    "fw_update_in_progress":false
  }
}

One note is that this implementation will optimistically set the new firmware
before the successful completion of a full or end transfer, for example:

  "firmware":{
    "num_slots":2,
    "active_slot":1,
    "staged_slot":2,
    "online_activate_capable":true,
    "slot_1_version":"BWFW VERSION 0",
    "slot_2_version":"BWFW VERSION 1",
    "fw_update_in_progress":true,
    "remaining_size":5091200
  }

Applies against Jonathan's latst branch:
	https://gitlab.com/jic23/qemu/-/tree/cxl-2023-11-02

Thanks!

Davidlohr Bueso (2):
  hw/cxl: Add Transfer FW support
  hw/cxl: Add Activate FW support

 hw/cxl/cxl-mailbox-utils.c  | 179 +++++++++++++++++++++++++++++++++++-
 include/hw/cxl/cxl_device.h |   9 ++
 2 files changed, 183 insertions(+), 5 deletions(-)

-- 
2.43.0

