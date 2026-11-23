Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795401814;
	b=CyTGudNmlMUhurUXN61amyNaoVYJiZ0kt+UUmAq9JIO6zdgAt1Vtu0+DfFMwC9eks2sT
	 JZyDsk+KjXlUX/lbZ/0zIM2L0jZ9pubxY3TCm+CIfYlxVSOlWd6EEfEXUSMGGXBx+UghF
	 1F9I/bTbbHI88A2RXnKbKT82q9F7sodPM/jwfRLfwgS/hjZwmvSGqEkDPZjskfgeesM7h
	 ZRYlsMvkNLrvB0n8wGPMcE+XVicWA+f/DcE1SIAA0qwZjffEAm9rxDwBMZXFnF+zY4T2a
	 1zX06qYFd97X+sl01RBAUnE2+APoAbtBIlWQ7hrnIBiNQYXJ9Eqa0cgDn0vZvF6w9AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795401814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=edLt5Tq/BLcPWiJ/50P772+XAlfYh5g07EE3TpZCGKk=;
	b=0I2Yi9BQa2+yZ0JSbFGDkrkXlkphuDeK2U87xlz7f1fbI67PwwvbJupezRwkmcEp3Jy/
	 h2wDByxshInJWnQyNBepLjH+UQpwHyWEWuq901c/5puINAlWE5xk+CJjrbVmiC0TpGgvK
	 dE1xp2VuF6kzkYMULunxy15R1zLB26zOz6PUGp5eBNdqQ1hxf0uwxBfmSY4L7ZcYwPII1
	 L3cbUbJ4E44htR8aQj/sWlNHIWWZU3rqmXo7BybEffHN0pO8wKCAFKoLZkK19JtDPeaKx
	 pwDxV7C2pNGEUuB++6BKHRzbp0XxW6foXjOlJerjFbtl10CuPISkW9akk/ODF/rsRpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z41RKKTf;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BDF606A31E
	for <linux-cxl@vger.kernel.org>; Mon, 23 Nov 2026 02:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85BDF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z41RKKTf
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b467581b98so25188165e9.0
        for <linux-cxl@vger.kernel.org>; Sun, 22 Nov 2026 18:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795401813; x=1796006613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=edLt5Tq/BLcPWiJ/50P772+XAlfYh5g07EE3TpZCGKk=;
        b=z41RKKTfhxE+vR7EsIrps3H7/BS1tcS39Sqf9sQqAKgSZB3S3Uix5FYU1qOrOCR+/q
         c0NRwlZFdThVnStdRTnaGi6m5o1xt6t92JAWwWdOMjJ6Nu4Ll0fPkPWSewO6+Gn9Hm+o
         qC2A0a9DUlWeQOyud69Q4E/DojX+NZStVIjCo2k5ug3LRvY6FtwnvhfWr1/ilGOSGWb0
         N44opGVKU3+NX6Ks8O05b8UgXeiBfJeTl/XmYCYrLlwSFprr0eE/IyQGfhqgtJz/CqRD
         WplN+ORhsJ9+G9Zc74uSm0HNN5+pWLn05r3bdR6ShgzfKUYnnFnjKtDc5C9T1Vhwc9bU
         /qGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795401813; x=1796006613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=edLt5Tq/BLcPWiJ/50P772+XAlfYh5g07EE3TpZCGKk=;
        b=i7XhRud4XlibEnZjX4Gc/fg4MVD9r6ThI2bzgvdtY70cZk5eFUSzo/wui5anhVoBZh
         LwG1jWJdgMlHwZ8t1A0uoWyb7f75T+IRBAQ3/7ln6O8aVLRoBiuiHpv2So6DiVyymunI
         mv23czfNxMBXxI0a1S+cegN+nDs+H3x2reMUMAJjriV3pVV3ztnpUXueuIfCzRS4dM6O
         feoorG6prvGOuzspnixeh7953vSwdKwZOleXnzuBpCiCy+Lyvc0FlLW2xM5Abd1ujPIk
         1OF0MEQYAcpIFmKOHX+1bcDgR1E/Gj+Pr1G+6bkIhRfTVQEx8ZZsqcpxkoX2WaW3DNt4
         aRWg==
X-Gm-Message-State: APuU4Z+yk2HTagUzakZJD7ke4mi8UJRg+SYEyhBTsr+CsuBWihPzzT2g
	PCe7wVaA44gMnyoO9oGv8kHMTcgDWuAbJ8pZYpYyrrPyPdyfd80t42jQXCRC/F52oT5efQ==
X-Gm-Gg: AZFdTZcuEQjhar3kI8ajbkdbmYRmMGBoadqYtBkFb8wskC4NRG94OTg4dX4DFJPVR9f
	Skb+OMYHTlHT6mPc/7C2zSVlnw9e33mopnEfhrtoJnad4H7lKmxdZh6l/EWgHqvSJSIY9Ao+xoB
	xAUTvGz8WlDyHK0gEdzLS5pD7UqLKNQ0bIABIW/hQ1J1nPiFakEV3k7y9FOlVVheH1/8yzcOdu3
	zfT+1MDA+4L0B/QW3fbX0cjTessMqqijfveECm2x84i0mbqBb7WDAwGFLHYIQJWJ0fHsA4VhZIj
	KwrYqbjRXNMvdBUUoSP43NeFQe57iywfSzTLjo6Ng3wptSL+4eXU0IbSm1yIRglv/efSNMmNVdT
	18cuGPIgIbe1W26ZnzS754GbTWo1sUvS5svB9RD79kHXFnpOgpglIFi/gGcZ2wNCZLTgT2PxnPq
	uwx2NiZrINu92yNszzNVYpWBtIEzdtuPHf+qRsLY77rKUPUYyFOim0cuLOS1OksAVf9Hc1YXY4d
	X2DOusNNIAbpAs6++5leVYtZJC17D8slSuGW/VNYD/Sny2B07He7C0LrDMKYwJ5utQIBd3+SOyF
	lQv63sY56hnD1VxZR585zH0k/2oD0s+GAfek
X-Received: by 2002:a05:600c:4e0d:b0:4ab:e27d:e241 with SMTP id 5b1f17b1804b1-4bb88922c6amr196520605e9.15.1795401812683;
        Sun, 22 Nov 2026 18:43:32 -0800 (PST)
Received: from Yee-680G4.lan ([178.162.242.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849247asm307444625e9.7.2026.11.22.18.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 18:43:32 -0800 (PST)
From: YeeLi <seven.yi.lee@gmail.com>
To: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org,
	yeeli <seven.yi.lee@gmail.com>
Subject: [ndctl PATCH] cxl/filter: reject trailing characters in identifiers
Date: Mon, 23 Nov 2026 10:43:25 +0800
Message-Id: <20261123024325.2321309-1-seven.yi.lee@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: yeeli <seven.yi.lee@gmail.com>

The CXL filter helpers parse identifiers with sscanf("%d") and
prefixed variants such as "mem%d".  These conversions stop at the
first non-digit, so a malformed identifier such as "0abc" or
"mem0abc" still matches object 0.

Reproduce on a system with CXL memdevs and regions:

    cxl list -M -m 0abc        # matches mem0
    cxl list -R -r region0abc  # matches region0

A typo in a destructive command such as
"cxl disable-memdev -m mem0abc" can therefore operate on mem0
instead of failing.

Require the whole token to be consumed by adding a trailing %c and
checking that the conversion returns only the expected fields.

Tested by building cxl locally and on the target test system.  Valid
forms (numeric ids, devnames, host names, "all" and lists) still
match, while "0abc", "mem0abc", "region0abc", "0x0" and "0.0" now
match nothing.  The same matrix passes for the memdev, bus, port,
endpoint, decoder and region filters.

AI disclosure: the analysis, reproducer and initial fix were produced
with an AI coding assistant (DeepSeek V4.1 Flash, OpenCode).  The
submitter reviewed and verified the change and added the sign-off.

Signed-off-by: yeeli <seven.yi.lee@gmail.com>
---
 cxl/filter.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/cxl/filter.c b/cxl/filter.c
index 5d634d3..bff4409 100644
--- a/cxl/filter.c
+++ b/cxl/filter.c
@@ -53,6 +53,7 @@ struct cxl_endpoint *util_cxl_endpoint_filter(struct cxl_endpoint *endpoint,
 	char *ident, *save;
 	const char *arg;
 	int endpoint_id;
+	char c;
 
 	if (!__ident)
 		return endpoint;
@@ -66,8 +67,8 @@ struct cxl_endpoint *util_cxl_endpoint_filter(struct cxl_endpoint *endpoint,
 		if (strcmp(arg, "all") == 0)
 			break;
 
-		if ((sscanf(arg, "%d", &endpoint_id) == 1 ||
-		     sscanf(arg, "endpoint%d", &endpoint_id) == 1) &&
+		if ((sscanf(arg, "%d%c", &endpoint_id, &c) == 1 ||
+		     sscanf(arg, "endpoint%d%c", &endpoint_id, &c) == 1) &&
 		    cxl_endpoint_get_id(endpoint) == endpoint_id)
 			break;
 
@@ -90,6 +91,7 @@ static struct cxl_port *__util_cxl_port_filter(struct cxl_port *port,
 	char *ident, *save;
 	const char *arg;
 	int port_id;
+	char c;
 
 	if (!__ident)
 		return port;
@@ -112,8 +114,8 @@ static struct cxl_port *__util_cxl_port_filter(struct cxl_port *port,
 		if (strcmp(arg, "endpoint") == 0 && cxl_port_is_endpoint(port))
 			break;
 
-		if ((sscanf(arg, "%d", &port_id) == 1 ||
-		     sscanf(arg, "port%d", &port_id) == 1) &&
+		if ((sscanf(arg, "%d%c", &port_id, &c) == 1 ||
+		     sscanf(arg, "port%d%c", &port_id, &c) == 1) &&
 		    cxl_port_get_id(port) == port_id)
 			break;
 
@@ -213,6 +215,7 @@ struct cxl_bus *util_cxl_bus_filter(struct cxl_bus *bus, const char *__ident)
 	char *ident, *save;
 	const char *arg;
 	int bus_id;
+	char c;
 
 	if (!__ident)
 		return bus;
@@ -226,8 +229,8 @@ struct cxl_bus *util_cxl_bus_filter(struct cxl_bus *bus, const char *__ident)
 		if (strcmp(arg, "all") == 0)
 			break;
 
-		if ((sscanf(arg, "%d", &bus_id) == 1 ||
-		     sscanf(arg, "root%d", &bus_id) == 1) &&
+		if ((sscanf(arg, "%d%c", &bus_id, &c) == 1 ||
+		     sscanf(arg, "root%d%c", &bus_id, &c) == 1) &&
 		    cxl_bus_get_id(bus) == bus_id)
 			break;
 
@@ -334,6 +337,7 @@ struct cxl_memdev *util_cxl_memdev_filter(struct cxl_memdev *memdev,
 	char *ident, *save;
 	const char *name;
 	int memdev_id;
+	char c;
 
 	if (!__ident)
 		return util_cxl_memdev_serial_filter(memdev, serials);
@@ -347,8 +351,8 @@ struct cxl_memdev *util_cxl_memdev_filter(struct cxl_memdev *memdev,
 		if (strcmp(name, "all") == 0)
 			break;
 
-		if ((sscanf(name, "%d", &memdev_id) == 1 ||
-		     sscanf(name, "mem%d", &memdev_id) == 1) &&
+		if ((sscanf(name, "%d%c", &memdev_id, &c) == 1 ||
+		     sscanf(name, "mem%d%c", &memdev_id, &c) == 1) &&
 		    cxl_memdev_get_id(memdev) == memdev_id)
 			break;
 
@@ -432,6 +436,7 @@ struct cxl_decoder *util_cxl_decoder_filter(struct cxl_decoder *decoder,
 	int pid, did;
 	char *ident, *save;
 	const char *name;
+	char c;
 
 	if (!__ident)
 		return decoder;
@@ -452,8 +457,8 @@ struct cxl_decoder *util_cxl_decoder_filter(struct cxl_decoder *decoder,
 		if (strcmp(name, "endpoint") == 0 && cxl_port_is_endpoint(port))
 			break;
 
-		if ((sscanf(name, "%d.%d", &pid, &did) == 2 ||
-		     sscanf(name, "decoder%d.%d", &pid, &did) == 2) &&
+		if ((sscanf(name, "%d.%d%c", &pid, &did, &c) == 2 ||
+		     sscanf(name, "decoder%d.%d%c", &pid, &did, &c) == 2) &&
 		    cxl_port_get_id(port) == pid &&
 		    cxl_decoder_get_id(decoder) == did)
 			break;
@@ -668,6 +673,7 @@ struct cxl_region *util_cxl_region_filter(struct cxl_region *region,
 	char *ident, *save;
 	const char *name;
 	int id;
+	char c;
 
 	if (!__ident)
 		return region;
@@ -681,8 +687,8 @@ struct cxl_region *util_cxl_region_filter(struct cxl_region *region,
 		if (strcmp(name, "all") == 0)
 			break;
 
-		if ((sscanf(name, "%d", &id) == 1 ||
-		     sscanf(name, "region%d", &id) == 1) &&
+		if ((sscanf(name, "%d%c", &id, &c) == 1 ||
+		     sscanf(name, "region%d%c", &id, &c) == 1) &&
 		    cxl_region_get_id(region) == id)
 			break;
 
-- 
2.34.1

