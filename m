Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E2A1C174A;
	Fri, 21 Mar 2025 03:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529571; cv=pass; b=iz6+C4BELn4Ir+LYUoUezwWjPflTx8Qs6KwjXa2ImnCIkwQyMoYSsu6mQbxsie0iDEiTb9nRHl6WrTq38kA0Hxi8gurFLlhSniLT5SMLonKhknL6CkbQB4afdtHH9qSHMfBTbCbMcZ8uJRufyzxejgiT7HCLZtNB3C5FCPaJi7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529571; c=relaxed/simple;
	bh=aFfYjpXXJ4M+8hXi2SGYDgMHE4lcqymrONqlLwxg3Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1QIaZb6XIC9C9OGW86KtrJKm+7MhZYqPdwmgXwxL5+vM4NV7+L7XxWY7HI+k3MsBcg88zLimKkWHgtPsm2ocrsOXY9+ZapBaNMzCvgC8ZIp7Xqy7kAxPcf3axDaLfNpHojy7xqEmTS+iUoq617cPMb/Xy3uN308vG3xUhuJqAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=oTJOjUSb; arc=pass smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="oTJOjUSb"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B84C8163D85;
	Fri, 21 Mar 2025 03:59:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a231.dreamhost.com (100-96-207-186.trex-nlb.outbound.svc.cluster.local [100.96.207.186])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 85980164D80;
	Fri, 21 Mar 2025 03:59:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1742529562; a=rsa-sha256;
	cv=none;
	b=F0RJXvSWSHTnIhpNgzln5OTRXDJ9b/hlQAED+zxrgHM0CH1mO5Bxk2toF2oBnBPiCnHDCz
	m+mdGqbI/KHWH8Mkju2L713I1Fo5vBzkCIKsyKeehR3WDkn9IJDQVobMSmJgMfIrOf+V9W
	APlq46XB+aGfNV+LOV7O6duRATf/P525HKX/MJI/W0A++f6FfaCBjnMi8lc4aJr4+JWXuH
	ub4p2KLErUvM2J6VqyyKRwaVUnb8QZQzGwc2gVEsh2OtaJAGINq5hto2VYI0TuFqAztK0B
	oTM6PhhUgOCSlqfgnEcIaBZ1tjscbmAITg59ODRXQ+bAYHdqd2/0r1e3bcB/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1742529562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=f09muvj1zbZ8O3iLc/6V5qba8mC06vgAkUEv+s5LLiA=;
	b=7Ru7q2LL7fqhZP3sJwW3zsNaxOJo7ptkwFBtUvvaGkm5nuhflwBqVuOil95ePgDGYnzHAB
	x6WYLlja0toJaKCUYkfTemB5dJJpdk8u5YmbTcM3IVKOn4WhY1LxdABs6BKE/gvV3w8W9u
	LejPCXz1sfbjR5pyhTX54s2dJ2xOnwQovRQYu5n2Gw3Kmv/CMK9MeL5XBeuZWD1YrKFtxe
	zi9Kweu/6CUVv1gP2/ksLlSvr9RDTkewkPkIrypBiP7VeFpcevB6VRIGitoOUV8iN5iv21
	uZFILXqECrIxduh3HLC6610rUUCDEWXh6f2k4mQ3GmtYBHnRPGJNwzWXQRNJxQ==
ARC-Authentication-Results: i=1;
	rspamd-67d8974966-4drm9;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Company-Tart: 459bdddb1dbe7e5e_1742529563640_1315007263
X-MC-Loop-Signature: 1742529563640:1402950586
X-MC-Ingress-Time: 1742529563640
Received: from pdx1-sub0-mail-a231.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.207.186 (trex/7.0.2);
	Fri, 21 Mar 2025 03:59:23 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a231.dreamhost.com (Postfix) with ESMTPSA id 4ZJpbs6mGfzB9;
	Thu, 20 Mar 2025 20:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1742529562;
	bh=f09muvj1zbZ8O3iLc/6V5qba8mC06vgAkUEv+s5LLiA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=oTJOjUSbpxweUwhJyVmmtbN8AGWutqwPeEYOFSLX3YFMgUbJizPqNiB4WQ3XKNIt+
	 lT46XQQfeyZbW8ag5a8IDIopf3ivroVKkM9K9DiPTuzs9zHdvTlZTs/HkSdjuzkKJw
	 +RvEmirdmHY0XDFgYH+gHwlmwWMam9xDNfrUgrccA+tsHWrd+I1onmp7HCDMzfqowL
	 RAYKTbCvpz0JEZovzS69ILXxkoWCJNlFBwzF13x+hv3XorAPpeeVOC895FQxPd5MeK
	 LW5KJuXKwawuuoGUSzjN3Wfim+FWXRfLObYQLipDb7Gz/aDlfx2HX6uOR8rWXbYyjy
	 ZnhyMKWIKGHwA==
Date: Thu, 20 Mar 2025 20:59:18 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Li Ming <ming.li@zohomail.com>
Cc: jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC Patch v1 0/3] Fix using wrong GPF DVSEC location issue
Message-ID: <20250321035918.yyicfmvmpm7selin@offworld>
References: <20250319035516.222054-1-ming.li@zohomail.com>
 <20250321021441.vdmo5txhvb6kya3a@offworld>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250321021441.vdmo5txhvb6kya3a@offworld>
User-Agent: NeoMutt/20220429

On Thu, 20 Mar 2025, Davidlohr Bueso wrote:

>On Wed, 19 Mar 2025, Li Ming wrote:
>
>>But I am not sure if all dports under a same port will have same
>>configuration space layout, if yes, that will not be a problem. If I am
>>wrong, please let me know, thanks.
>
>Yes, when caching the dvsec was suggested, it was my assumption that the
>config space would be the same.

Ultimately I don't know what the expectation is here, but your updates
do allow more flexibility from vendors, I guess(?). It's a bit late
in the cycle, unfortunately, so if these are to go in for v6.15, they
would be considered a fix imo, otherwise perhaps they are wanted for
v6.16 or not at all (patch 3 does look useful regardless)?

Based on some of the topologies listed in qemu, I did some testing (and
this was also why the same dvsec config layout) and see things working as
expected.

https://www.qemu.org/docs/master/system/devices/cxl.html#example-command-lines

(i) 2 direct-attached Type3 devices:
-next
[    3.938238] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:0c:00.0: Port GPF phase 1 timeout: 20 secs
[    3.939323] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:0c:00.0: Port GPF phase 2 timeout: 20 secs
[    4.003074] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:0c:01.0: Port GPF phase 1 timeout: 20 secs
[    4.003676] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:0c:01.0: Port GPF phase 2 timeout: 20 secs
-next+fix
[    3.969841] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:0c:00.0: Port GPF phase 1 timeout: 20 secs
[    3.970957] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:0c:00.0: Port GPF phase 2 timeout: 20 secs
[    3.971622] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:0c:01.0: Port GPF phase 1 timeout: 20 secs
[    3.972664] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:0c:01.0: Port GPF phase 2 timeout: 20 secs

(ii) 2 CXL host bridges. Each host bridge has 2 CXL Root Ports, with the CXL Type3 device directly attached:
-next
[    6.182333] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:de:00.0: Port GPF phase 1 timeout: 20 secs
[    6.182352] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:de:00.0: Port GPF phase 2 timeout: 20 secs
[    6.183938] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:0c:01.0: Port GPF phase 1 timeout: 20 secs
[    6.183955] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:0c:01.0: Port GPF phase 2 timeout: 20 secs
[    6.204324] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:0c:00.0: Port GPF phase 1 timeout: 20 secs
[    6.205407] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:0c:00.0: Port GPF phase 2 timeout: 20 secs
[    6.210006] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:de:01.0: Port GPF phase 1 timeout: 20 secs
[    6.210921] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:de:01.0: Port GPF phase 2 timeout: 20 secs
-next+fix
[    6.153093] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:0c:01.0: Port GPF phase 1 timeout: 20 secs
[    6.153107] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:0c:01.0: Port GPF phase 2 timeout: 20 secs
[    6.154170] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:de:01.0: Port GPF phase 1 timeout: 20 secs
[    6.154187] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:de:01.0: Port GPF phase 2 timeout: 20 secs
[    6.195279] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:de:00.0: Port GPF phase 1 timeout: 20 secs
[    6.195859] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:de:00.0: Port GPF phase 2 timeout: 20 secs
[    6.255782] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:0c:00.0: Port GPF phase 1 timeout: 20 secs
[    6.257152] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:0c:00.0: Port GPF phase 2 timeout: 20 secs

(iii) 4 Type3 devices below a CXL Switch:
-next
[    3.940200] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:0e:01.0: Port GPF phase 1 timeout: 20 secs
[    3.940218] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:0e:01.0: Port GPF phase 2 timeout: 20 secs
[    3.940231] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:0e:00.0: Port GPF phase 1 timeout: 20 secs
[    3.940245] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:0e:00.0: Port GPF phase 2 timeout: 20 secs
[    3.940340] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:0c:00.0: Port GPF phase 1 timeout: 20 secs
[    3.940350] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:0c:00.0: Port GPF phase 2 timeout: 20 secs
[    3.948114] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:0e:02.0: Port GPF phase 1 timeout: 20 secs
[    3.949203] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:0e:02.0: Port GPF phase 2 timeout: 20 secs
[    3.997620] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:0e:03.0: Port GPF phase 1 timeout: 20 secs
[    3.997641] cxl_core:update_gpf_port_dvsec:1125: pcieport 0000:0e:03.0: Port GPF phase 2 timeout: 20 secs
-next+fix
[    3.983632] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:0e:01.0: Port GPF phase 1 timeout: 20 secs
[    3.983649] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:0e:01.0: Port GPF phase 2 timeout: 20 secs
[    3.984525] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:0c:00.0: Port GPF phase 1 timeout: 20 secs
[    3.984539] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:0c:00.0: Port GPF phase 2 timeout: 20 secs
[    3.984667] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:0e:03.0: Port GPF phase 1 timeout: 20 secs
[    3.984692] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:0e:03.0: Port GPF phase 2 timeout: 20 secs
[    3.985074] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:0e:02.0: Port GPF phase 1 timeout: 20 secs
[    3.985090] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:0e:02.0: Port GPF phase 2 timeout: 20 secs
[    3.988954] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:0e:00.0: Port GPF phase 1 timeout: 20 secs
[    3.990464] cxl_core:update_gpf_port_dvsec:1131: pcieport 0000:0e:00.0: Port GPF phase 2 timeout: 20 secs

Thanks,
Davidlohr
