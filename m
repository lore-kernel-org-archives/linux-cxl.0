Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.223.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219312;
	b=TwVzhJ909K8cmCBMrpbPlqrDUtdK/9AeY7oDkyl1u9FLVDYSiT1mwHMlHq+qyOyCBHcj
	 AjWXOK1evMl3pE9lujdaB2rO4T+uFjwqori2V8O4IEGxlaYi2rWNNOuw4A3UvwzrNg1UT
	 tefXCn5SxeTHLBAlt7RVBKnGp7k4gAvCQoPE/snaHqGTbxtzTt2/c5uplCaViRU5QmP3s
	 JnHyY1N1duoRR8XPBGwAn3Er2yj9TmbXF31WQ3m0n/seD2B5V44LDOVe+4DUI3gis8gJE
	 q5rGXZ981pBq3opuRnOro2gKtWBr9d9Nq9jsMeUu05DvD3n6B+EDXs1BT3mf9pETEdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219312;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Fearful-Stop:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=z8zZuGb2nv/jHGNtvdfW8XIv7TwiDR0piCVyjL7VmA8=;
	b=3z9jDZE+9M2hyDJ7ZCqfMLSxAuIm/kebYXmuyRMTc73BfOg3s38s+ueqp14d8a3qgTbd
	 w7VbbU+Iyl6p36max1FyQE6IzeHIXyCZr/rQmM9Su32fBIczy5lcv5BiRCWaYZ5bkTCHY
	 oS3Y4r+dU/wEkHs3nTFEJtU+FFADoZpMyseayGomcWN3Lnz3qK2kJgOWS1iNqaqu7xG8T
	 nivdsIm5GZF37IjLkIN6cYWOoKgu1wozr0ntsieoHWIn57L7cDRsuePNXtvdtuUom867N
	 QcTGI4k6rVrq6gaGMpeAdk0FzG4mAvMuURDIw+6anviCoOZosUs3B+wrfTxVotxg3hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b="O/NvfTAX";
	arc=none smtp.remote-ip=23.83.223.216
Received: from puffin.cherry.relay.mailchannels.net (puffin.cherry.relay.mailchannels.net [23.83.223.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9916E606A31A
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 20:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9916E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=O/NvfTAX
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 992284E446C;
	Wed, 28 Oct 2026 20:28:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (trex-green-5.trex.outbound.svc.cluster.local [100.96.7.165])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 248CC4E42B5;
	Wed, 28 Oct 2026 20:28:21 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Fearful-Stop: 4aabd388072e605f_1793219305342_400650209
X-MC-Loop-Signature: 1793219305342:1411674173
X-MC-Ingress-Time: 1793219305342
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.7.165 (trex/8.0.2);
	Wed, 28 Oct 2026 20:28:25 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4jFJpX4Fpwz103Q;
	Wed, 28 Oct 2026 13:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793219301;
	bh=z8zZuGb2nv/jHGNtvdfW8XIv7TwiDR0piCVyjL7VmA8=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=O/NvfTAXRBCUeJ64UL/OfJD92QG1kGM1Mp7sI+in6IswLS2pe+WtWRdDnDdQ3sSJa
	 mSE6VdEUGrrqb+fp+phihQDl//1adBiC+pVB/eAL2/wmIoRd8bvCEeVW0GINQ/USHq
	 A1Pn5F2OGgHKhOHU2EGhEomgGK90g9RQtsA9eRwNY9mMVDkiWDuAxM3F31IeWuJ6ye
	 rVkAI/YMdpKl+cakiLz5ktwGUw76hl+sRCjtehx0M/OPFp4/X9Bprg/inSH8YCAxgi
	 5gfkCJLP3zEZ7fB7YZlsav9w2dSWJ3HSVQq3DaAesw9GAdqfuGwbswDLxyQEoC4njM
	 QND0kGqKezThA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	ming.li@zohomail.com,
	icheng@nvidia.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH] cxl/acpi: Drop the root decoder target_type assignment
Date: Wed, 28 Oct 2026 13:27:57 -0700
Message-Id: <20261028202757.912948-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A root decoder's target_type is never consumed. The field is
already initialized to CXL_DECODER_HOSTONLYMEM by cxl_decoder_init().
Drop the redundant assignment, which only suggests the root decoder's
type matters.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index b7ce6b59c680..740e229e1c4c 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -443,8 +443,6 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 
 	cxld = &cxlrd->cxlsd.cxld;
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
-	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 	cxld->hpa_range = (struct range) {
 		.start = cfmws->base_hpa,
 		.end = cfmws->base_hpa + cfmws->window_size - 1,
--
2.39.5

