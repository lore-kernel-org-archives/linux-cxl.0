Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.212.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795055444;
	b=2aCjo5muHNVfNM9SbOo3atGO29dNQmoybhYMw54EpQzD9X+hYkIIZgNHXbMh0Vw8mfzx
	 JjINzPJW6vFJvr+GRVL/DmrS65MdFjHu1UIDu3Iwi8qeeGOuR/DLuD8SoXiAlUg17x4kN
	 B1PsWxtPpXSsn9lm/fsamzNlCNr/WcaelG12Ymd0KS8WccGUyc0BQHtgzEiMkObTfTN6f
	 XnUFcQUZYLpErA6fcq91mc9MEOn4m7MhF1tt1EekyAFMs2W/Dc/HfB4Y8FZskJuVV3wxc
	 LgVBWevlrfZuhnlXu+ZTyBSdyag6gVkiEdep/baA4lGjJad+zRUOl3y1BLT3oYaGsjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795055444;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Scare-Illegal:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=odpgVvQxoVIUP2TRoLvMKGzTKw8uurYOBWkrR0hOEUM=;
	b=Fet1yhWDMuWfYakcbol0EpuptkYs7apAFzMZdOgWKhQ8MooNvro3F5rPTDyfEK6M51V4
	 dWad1hxXQzjiZOIezoTN+6PHnwDidnQoqpZeg6ZyGvdMu90YJtowe8cV4hL75t/a8ngLJ
	 ACOyID4A3IwPaOGFixmunKQh3TgHEjhs5PYOGy54AUK47QSyBCOuicugLnh0rRRthryrL
	 iB4kOwXUBW5/PWlahC1TOWap323DvOxt9HiBEFoPrq5uWAMTkeb9k5zIhJcZKS6397YHt
	 HQDqIZBBfDX1HpFiXOChuy+3D3lEtgtIayf9QGMW9faLSQz2e4xf9gxh6HxDSZXtnDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=mzvvfqCP;
	arc=none smtp.remote-ip=23.83.212.19
Received: from black.elm.relay.mailchannels.net (black.elm.relay.mailchannels.net [23.83.212.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA00C606A332
	for <linux-cxl@vger.kernel.org>; Thu, 19 Nov 2026 02:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA00C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=mzvvfqCP
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7787B7A10F4;
	Thu, 19 Nov 2026 02:30:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (100-103-220-8.trex-nlb.outbound.svc.cluster.local [100.103.220.8])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4F6947A051A;
	Thu, 19 Nov 2026 02:30:37 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Scare-Illegal: 196087ac5ce3276b_1795055437389_1522502550
X-MC-Loop-Signature: 1795055437389:1788871034
X-MC-Ingress-Time: 1795055437388
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.220.8 (trex/8.0.2);
	Thu, 19 Nov 2026 02:30:37 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4jVMrr5Jf2z1V;
	Wed, 18 Nov 2026 18:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1795055437;
	bh=odpgVvQxoVIUP2TRoLvMKGzTKw8uurYOBWkrR0hOEUM=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=mzvvfqCPjFx6P3YvvO+7dY3dE/pVPsNynZQkghJMPyNSvTWAV+oCDYl25Ltr0V+BV
	 6ttcedLOgM0XaJS1tYelYTLU1XS2e7iEmyf/L9WEyrFSWVCJahRLgRDpK0cyWJFQO5
	 8PADKiE2mc2Mq5awHY3JnsO5BsvAFr65SeGcr2T2Jq+JPa9XaAUBN6LznVcwroRo2k
	 rdDK73AEuC5G61MDksyFLTF2TTIzxSjSwAKD+F4aVtkXisNaRjSbt4VQUWlvEujedA
	 sIUSm18QGP6evO07l++kwPb414LdUs/LJlHGRS8cduA/H/umSFW4osaMyzK4UlqRi+
	 5ms1P3t817DzQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: alison.schofield@intel.com
Cc: dave.jiang@intel.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 2/2] libcxl: report Back-Invalidate decoder state
Date: Wed, 18 Nov 2026 18:30:28 -0800
Message-Id: <8f761db5611a1a141f0cf8209566134238c0915b.1795050773.git.dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795050773.git.dave@stgolabs.net>
References: <cover.1795050773.git.dave@stgolabs.net>
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

The kernel exposes two Back-Invalidate attributes: cap_back_invalidate
on a root decoder, for a CFMWS window carrying the BI restriction, and
back_invalidate on an endpoint decoder, set while it decodes an HDM-DB
region. Update libcxl accordingly.

A root decoder whose window permits BI:

  {
    "decoder":"decoder0.6",
    "resource":70308077764608,
    "size":1073741824,
    "interleave_ways":1,
    "accelmem_capable":true,
    "back_invalidate_capable":true,
    "qos_class":42,
    "nr_targets":1
  }

An endpoint decoder currently decoding a region under it:

  {
    "decoder":"decoder9.0",
    "resource":70308077764608,
    "size":1073741824,
    "interleave_ways":1,
    "region":"region6",
    "dpa_resource":0,
    "dpa_size":1073741824,
    "mode":"ram",
    "back_invalidate":true
  }

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/cxl/lib/libcxl.txt |  2 ++
 cxl/json.c                       | 16 ++++++++++++++++
 cxl/lib/libcxl.c                 | 15 +++++++++++++++
 cxl/lib/libcxl.sym               |  6 ++++++
 cxl/lib/private.h                |  2 ++
 cxl/libcxl.h                     |  2 ++
 6 files changed, 43 insertions(+)

diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index 5c3ebd4b786b..187e19f99ec0 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -461,6 +461,8 @@ bool cxl_decoder_is_pmem_capable(struct cxl_decoder *decoder);
 bool cxl_decoder_is_volatile_capable(struct cxl_decoder *decoder);
 bool cxl_decoder_is_mem_capable(struct cxl_decoder *decoder);
 bool cxl_decoder_is_accelmem_capable(struct cxl_decoder *decoder);
+bool cxl_decoder_is_back_invalidate_capable(struct cxl_decoder *decoder);
+bool cxl_decoder_is_back_invalidate(struct cxl_decoder *decoder);
 bool cxl_decoder_is_locked(struct cxl_decoder *decoder);
 ----
 The kernel protects the enumeration of the physical address layout of
diff --git a/cxl/json.c b/cxl/json.c
index a92548828582..ae4a936cf26c 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -927,6 +927,22 @@ struct json_object *util_cxl_decoder_to_json(struct cxl_decoder *decoder,
 					       jobj);
 	}
 
+	if (cxl_port_is_root(port) &&
+	    cxl_decoder_is_back_invalidate_capable(decoder)) {
+		jobj = json_object_new_boolean(true);
+		if (jobj)
+			json_object_object_add(jdecoder,
+					       "back_invalidate_capable", jobj);
+	}
+
+	if (cxl_port_is_endpoint(port) &&
+	    cxl_decoder_is_back_invalidate(decoder)) {
+		jobj = json_object_new_boolean(true);
+		if (jobj)
+			json_object_object_add(jdecoder, "back_invalidate",
+					       jobj);
+	}
+
 	if (cxl_port_is_root(port)) {
 		int qos_class = cxl_root_decoder_get_qos_class(decoder);
 
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index e55a7b41d77a..fa8dc8b1ab3e 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -2490,6 +2490,9 @@ static void *add_cxl_decoder(void *parent, int id, const char *cxldecoder_base)
 
 	switch (port->type) {
 	case CXL_PORT_ENDPOINT:
+		sprintf(path, "%s/back_invalidate", cxldecoder_base);
+		if (sysfs_read_attr(ctx, path, buf) == 0)
+			decoder->back_invalidate = !!strtoul(buf, NULL, 0);
 		sprintf(path, "%s/dpa_resource", cxldecoder_base);
 		if (sysfs_read_attr(ctx, path, buf) < 0)
 			decoder->dpa_resource = ULLONG_MAX;
@@ -2528,6 +2531,8 @@ static void *add_cxl_decoder(void *parent, int id, const char *cxldecoder_base)
 			{ "cap_type3", &decoder->mem_capable },
 			{ "cap_ram", &decoder->volatile_capable },
 			{ "cap_pmem", &decoder->pmem_capable },
+			{ "cap_back_invalidate",
+			  &decoder->back_invalidate_capable },
 			{ "locked", &decoder->locked },
 		};
 
@@ -2839,6 +2844,16 @@ CXL_EXPORT bool cxl_decoder_is_accelmem_capable(struct cxl_decoder *decoder)
 	return decoder->accelmem_capable;
 }
 
+CXL_EXPORT bool cxl_decoder_is_back_invalidate_capable(struct cxl_decoder *decoder)
+{
+	return decoder->back_invalidate_capable;
+}
+
+CXL_EXPORT bool cxl_decoder_is_back_invalidate(struct cxl_decoder *decoder)
+{
+	return decoder->back_invalidate;
+}
+
 CXL_EXPORT bool cxl_decoder_is_locked(struct cxl_decoder *decoder)
 {
 	return decoder->locked;
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index ed4429f175ef..599d45e07350 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -320,3 +320,9 @@ LIBCXL_12 {
 global:
 	cxl_region_locked_state;
 } LIBCXL_11;
+
+LIBCXL_13 {
+global:
+	cxl_decoder_is_back_invalidate_capable;
+	cxl_decoder_is_back_invalidate;
+} LIBCXL_12;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index d2d71fc1a9f0..e5e532c52611 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -161,6 +161,8 @@ struct cxl_decoder {
 	bool volatile_capable;
 	bool mem_capable;
 	bool accelmem_capable;
+	bool back_invalidate_capable;
+	bool back_invalidate;
 	bool locked;
 	enum cxl_decoder_target_type target_type;
 	int regions_init;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index e91af905be3a..fcc1340d02b2 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -265,6 +265,8 @@ bool cxl_decoder_is_pmem_capable(struct cxl_decoder *decoder);
 bool cxl_decoder_is_volatile_capable(struct cxl_decoder *decoder);
 bool cxl_decoder_is_mem_capable(struct cxl_decoder *decoder);
 bool cxl_decoder_is_accelmem_capable(struct cxl_decoder *decoder);
+bool cxl_decoder_is_back_invalidate_capable(struct cxl_decoder *decoder);
+bool cxl_decoder_is_back_invalidate(struct cxl_decoder *decoder);
 bool cxl_decoder_is_locked(struct cxl_decoder *decoder);
 unsigned int
 cxl_decoder_get_interleave_granularity(struct cxl_decoder *decoder);
-- 
2.39.5

