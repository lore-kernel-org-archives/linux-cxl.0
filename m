Received: from slateblue.cherry.relay.mailchannels.net (slateblue.cherry.relay.mailchannels.net [23.83.223.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D189215077
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 22:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750198518; cv=pass; b=o60zXeq3xTy68ZPyWgBPPTrIQmG6wBXVktkTgoLtoppX4CXdFkJdUPlU8Hk56P9XXq/aihnmomS3ogYninN1XUd7QjMX8xClO4zgZiEMs2cYCQ1xKymKHJrk/8ch0Dfwt+O7sve0Kc0LWeJAkcpFdLy4dPUBeWYrhZXQ3XqsBMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750198518; c=relaxed/simple;
	bh=br1JxbEqjp+XKPoJ5VINwswLzpe79a/gzx3L6lmu6Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzBq+getnD7i4nt/GzuNDUEXHk6s5hDn1+Am5fnOTXZGRppVzb9Q3y2a5cpQO23zrlhGPmGckaJYsXuh92zEpMW5U9VVwmKwtZ88EgdN+HtBPf1K73+UoznHxw/3Pglj+swnMVsuMdlNQMSLvbzwXMd4hJGf9kFyyR0nmehn2qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=TEdCt42j; arc=pass smtp.client-ip=23.83.223.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="TEdCt42j"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 57629845564;
	Tue, 17 Jun 2025 22:15:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a309.dreamhost.com (100-100-12-242.trex-nlb.outbound.svc.cluster.local [100.100.12.242])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id AEC5F844C9F;
	Tue, 17 Jun 2025 22:15:13 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1750198513; a=rsa-sha256;
	cv=none;
	b=pxTJysnzi0QORDS+VW1g6Vmaxql1P1GUBWI1N9yzI7slu5zwBaK0vI/pMKIK4xGMYbbO7A
	fBIfKDaLUsV4/TuW3FVOE+0UrEwV9nGLnw+CUPUKd/M9hajVePN9yGhrh+8IHwFw6BaLaU
	ok7ADqTeD+dXn+JcLz5ISLlY4K8ybb8zSoYsVGZb7Virc2fTp/vg0c9TkYUamnvu/It3dO
	q5jGuc2KoOah6YU7FcgdT4mq+zlTtudc9A686Iuo0LFWWv7jy7cUoWcHLfm89LlrtfAorc
	vU0eied5v3eufPOeQyiQP36+mtNm4VIWQYwVLVAhZ0Nxzlnx43FxzXrxWjkxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1750198513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sO2Gd2Lsd0N4J7D4BaAlkKkuEFB73n5zDQ9oBJo4ENY=;
	b=B/OBPvHVdwPgiAWefPc7g75e3MrcVdR7962fcr8S9hKoWpPrTXaXpeV9Qzld3QkNUwUb4l
	k4TjfYypSguNTMWGqGYfFcPo8fT4zcKijeSraFpuh3wTRWybONl+lzLyN/cGBzA81qtTHw
	j/n0cz9LM6uAZh2TNMavofFxdoCwwZw8A7aY0oTWnfgyAI0X051A8n5XWiyro6sH+PN3pe
	WRx/sfEebyxjU+VoYY79x2oqtbvvHr/z4cDjOuEye9JkO84PS2rEx0b7EsW/FVPmPffQX6
	odLo0cvWThJF3zHEoZ8WI6SPy18/Su6Fjj2AOV2qhYY0Ykc2pWajIBlL/trBTw==
ARC-Authentication-Results: i=1;
	rspamd-5859dfb5d9-hh9g8;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shrill-Shade: 76d5d434554d88e7_1750198514055_284077636
X-MC-Loop-Signature: 1750198514054:2714795775
X-MC-Ingress-Time: 1750198514054
Received: from pdx1-sub0-mail-a309.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.12.242 (trex/7.0.3);
	Tue, 17 Jun 2025 22:15:14 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a309.dreamhost.com (Postfix) with ESMTPSA id 4bMLlh5hc1z1P;
	Tue, 17 Jun 2025 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1750198513;
	bh=sO2Gd2Lsd0N4J7D4BaAlkKkuEFB73n5zDQ9oBJo4ENY=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=TEdCt42jpFsJdI4cE13WcxYOkQXwrt4jTW0Fam5sEFNptleurNKVWZ9mtxI1j+/iU
	 7CONWhWd6HCm6FzzajUUAV1PaF9k670mj3rhviyPXFNvDHMfwx65rtq/rHitxKfJIJ
	 CVpO5pBdxPlUVnWn4rG2NKy2YO4NzgXkKSCfw98fvyH5cD9Foi06pTfWQwjdi3g+JD
	 M0BgWBrqhBzeBTri6VSkqkrkQI8yk6KdUt9+414vZvmeDEyTRNOcGYGk67cpZg7rn9
	 s8dg1FOqLECMMbtHjQFfk1gRIYsx+KwZW9R3aSE3yAriD+vJ/6JfP9RIw0nbBr+nWW
	 AQHKV1pTFP6oA==
Date: Tue, 17 Jun 2025 15:15:09 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: dan.j.williams@intel.com, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, jgroves@micron.com, ravis.opensrc@micron.com,
	fan.ni@samsung.com, anisa.su@samsung.com, a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 7/7] cxl/mbox: Add Populate Log support
Message-ID: <20250617221509.ro27iocdmfllvvwg@offworld>
References: <20250617193611.564668-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250617193611.564668-1-dave@stgolabs.net>
User-Agent: NeoMutt/20220429

=46rom: Ravi Shankar <ravis.opensrc@micron.com>

Adding UAPI support for
  CXL r3.1 8.2.9.5.5 Populate Log.

Signed-off-by: Ravi Shankar <ravis.opensrc@micron.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Apologies, this one had not gone out.

  drivers/cxl/core/mbox.c      | 1 +
  drivers/cxl/cxlmem.h         | 1 +
  include/uapi/linux/cxl_mem.h | 1 +
  3 files changed, 3 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index abb6bb77a43d..ef737f9dacf2 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -60,6 +60,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_CO=
MMAND_ID_MAX] =3D {
  	CXL_CMD(GET_LOG_CAPS, 0x10, 0x4, 0),
  	CXL_CMD(CLEAR_LOG, 0x10, 0, 0),
  	CXL_CMD(GET_SUP_LOG_SUBLIST, 0x2, CXL_VARIABLE_PAYLOAD, 0),
+	CXL_CMD(POPULATE_LOG, 0x10, 0, 0),
  	CXL_CMD(SET_PARTITION_INFO, 0x0a, 0, 0),
  	CXL_CMD(SET_LSA, CXL_VARIABLE_PAYLOAD, 0, 0),
  	CXL_CMD(GET_ALERT_CONFIG, 0, 0x10, 0),
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ebd7679143dd..56d5f9ea823a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -555,6 +555,7 @@ enum cxl_opcode {
  	CXL_MBOX_OP_GET_LOG		=3D 0x0401,
  	CXL_MBOX_OP_GET_LOG_CAPS	=3D 0x0402,
  	CXL_MBOX_OP_CLEAR_LOG           =3D 0x0403,
+	CXL_MBOX_OP_POPULATE_LOG        =3D 0x0404,
  	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST =3D 0x0405,
  	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	=3D 0x0500,
  	CXL_MBOX_OP_GET_FEATURE		=3D 0x0501,
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index c6c0fe27495d..ca7fbd1be873 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -50,6 +50,7 @@
  	___C(GET_LOG_CAPS, "Get Log Capabilities"),			  \
  	___C(CLEAR_LOG, "Clear Log"),					  \
  	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
+	___C(POPULATE_LOG, "Populate Log"),				  \
  	___C(MAX, "invalid / last command")
 =20
  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
--=20
2.39.5

