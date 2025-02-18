Received: from seashell.cherry.relay.mailchannels.net (seashell.cherry.relay.mailchannels.net [23.83.223.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182AE17BA5
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 03:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739935456; cv=pass; b=g+/RCXhrR7QGW2kWSi4AGrV4X+GPtL14cqWuVjmgo/OpvhH7ccVurThH9FU06lCBh8s2AdquQmL+r3XAeIJXKoTAXdRI3qjRKUC9Ljv9ik2UzMDWg/TVbdsR2gEMZZL+7cXIniMv5kCZ00UrX12Rno+EBjsbUbV02OtPoU83NZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739935456; c=relaxed/simple;
	bh=RCw3V1krApbkl9zaFDDWarre7JXdtqzlkegTWaAykW8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CI+zQoWmpOFIneTPFsjYmbD5nkJNLG5IfbFmG6J/dF5RIHdKOSa4Y8XqGFyODcigLwd7dQHPtDBzEdx47k1r4eh0l4AGtLSJQPFuVinILqQkMtKeICrxPqfEn7VigVqK/yMBYV/BU5F0JSe1opigDxw6CFQKL68i1jlPXNAwyJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=MstzAUDM; arc=pass smtp.client-ip=23.83.223.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="MstzAUDM"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AE4E01C23FA;
	Tue, 18 Feb 2025 22:49:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a303.dreamhost.com (trex-4.trex.outbound.svc.cluster.local [100.101.208.230])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4DDEC1C25E5;
	Tue, 18 Feb 2025 22:49:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739918974; a=rsa-sha256;
	cv=none;
	b=wPW/iHJu83vXzZOMH5PF2muioanVVTiNJ4Em7s2IiIE/uyOjE+s1TGVLQoRz9PjMDWMEfL
	SczQOJl4jGzYsSSyP3eBIcRLug5kFS7OEJvqlmsI0A5lgn0jJ1IC/DvS/rUeC0GFZ/IDpD
	9ABjGOtFU2+1KU9KNQYwQxtI6obmpToG4Na3bTrFaUITYQcOSbiiT/gTwiKmM2xvgRtler
	2Ujh1HemCeyZwjxo1/JL30tcAsc61/TiqWv3m70I8DNOkLE3X+1NhPswMLG+XZagw6M1WF
	E4w/IwWZJ1gKJcNlHzqJDh5+qQpFq8hEaIXAxX+kbd1yIBRbj4twV8NonDTBUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739918974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=xhgkMV+q6c3AN2+KwQCziPEUXItTuHl2NvKejHVyVbc=;
	b=xxW1Tm1QNCFeRAkJMlUln7k5R7fFBk+6A18hrBTs45mBMSEk4IEUCzw4+hC2VzzGpmqgek
	3rX3ElHrE6RHPtVYBceAuyWj7PsI6RQax8wzi9bgNqgUsO9n9YRoiHACJftNIzDFNKDW1I
	uEf0J083lOxlk2lWnBR+bdXySw+D5CNUV2AsPV/C617r8W9qcFVaZgMydYnLFJXd6RwU7R
	Cmg65Bd9P0Q2AasiRNdSiOj4M9k6vMBmlsaBLXqk5gRl5oJegPyzbdlt6fOO15K451T269
	lVltFGTj3MSnlyoUqXiSAI9vo5ZCutZNfGZfPQYV2vZTW37yb5f/PW0830VSEg==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-zs4ks;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Desert-Zesty: 08bfefe60cf0319b_1739918974579_3911529985
X-MC-Loop-Signature: 1739918974579:1630911662
X-MC-Ingress-Time: 1739918974578
Received: from pdx1-sub0-mail-a303.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.208.230 (trex/7.0.2);
	Tue, 18 Feb 2025 22:49:34 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a303.dreamhost.com (Postfix) with ESMTPSA id 4YyF8F57Rpz80;
	Tue, 18 Feb 2025 14:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1739918974;
	bh=xhgkMV+q6c3AN2+KwQCziPEUXItTuHl2NvKejHVyVbc=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=MstzAUDMbBUMm8QtAWtPyTkT9PniYuTBW6v1AOMWOXD5Xg9fu5dPos8esIJj3v/mp
	 Y4NlM2jGOWPHSMAgP+YZAncenyhMXx3DB49mG71HgRjy9w4nW45IBZBJYsWSxKgvG2
	 kxnPakMojH0xTcjNkugpbTQUXblx0UGTcGSfYjqmbRYGKSnJPsjyFVk4ppshcGT9MM
	 4r7qiF2/AmBs1Gi5y006WcE4pscgzvXvM25ehncaDfcqAP8cIWJ4gmgEDbMEx/SbNq
	 A39OK6mbi8U8rPMBu+A1qa3Mu8NDszmt6fFIO7mVMQiHf8J10rcUJZ0I6k01NDRX8b
	 AOiJTJwyYCBJQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/2] cxl: Some ABI doc updates
Date: Tue, 18 Feb 2025 14:48:51 -0800
Message-Id: <20250218224853.67457-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Two small ABI doc fixes.

Changes from v1: - picked up review
                 - s/Mb/MB in patch 2 (Jonathan)

Thanks!

Davidlohr Bueso (2):
  cxl: Plug typos in ABI doc
  cxl: Document missing sysfs files

 Documentation/ABI/testing/sysfs-bus-cxl | 26 +++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

--
2.39.5

