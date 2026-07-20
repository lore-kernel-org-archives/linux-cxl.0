Received: from panther.cherry.relay.mailchannels.net (panther.cherry.relay.mailchannels.net [23.83.223.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A512FD1A5
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 23:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784590769; cv=none; b=SQk/QUKeAK7ItKiUn3qkYv5s4O+v8Ft9Axgq1ObeLOc4WTTS0pjAXueQlsogZC6tIuqoWkWrZ+FOzcBRg7ECfSNd6LNWzff7oNbihZORSEAgX4UM4ZOIgmfbmOCwoWrVyBi9sEfP4f1sekCVwMx7u8q3uV0OfHg12O/N3DYv7TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784590769; c=relaxed/simple;
	bh=u7YxdGAECh2FyxDtfbZ9aPN7KqPVKTf7Mfc+952w0Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ih8+CXQEjs7R52L8uNWjw6vehK5VtbsfDmMGHXc7Jd1N1MtjVnLUGBD/4BOBskg+36YfemZsYhBfryYrVQse/ssHIBJ4TGE1cW0yMqmoXNfMWQ+UBQfDzWb8r+tXK0VXb40JqKqMG3EMqaj3cqkMsL0akh3Iyu5wD+Fhu0VrI8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=gZkm89AA; arc=none smtp.client-ip=23.83.223.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="gZkm89AA"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6714F462DC5;
	Mon, 20 Jul 2026 23:33:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.103.95.92])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0ADD8462D36;
	Mon, 20 Jul 2026 23:33:08 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Oafish-Duck: 2aab881147c254fa_1784590388283_1795428076
X-MC-Loop-Signature: 1784590388283:2343086391
X-MC-Ingress-Time: 1784590388283
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.95.92 (trex/8.0.2);
	Mon, 20 Jul 2026 23:33:08 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h3xdv3slCz1Pv;
	Mon, 20 Jul 2026 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1784590387;
	bh=hnKcICFiOcSlluv0YXDs2SsxD7mzY5SwQEcsVTozuQI=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=gZkm89AAhy3ELFaf5S+nJeWWtKrnIQncNTCzAwyNdynoMjU7dHheW128gUlJCOxsk
	 IvBXols7dF6i+T5YZ+w7mv/CvbyjuGrBDcapfvz9rtePgLN84wlvrts34oRxLuHJbt
	 Ycpq/aSK+xswY+BoPmJei+7EmMxMfs+PKnIMFGneVuKreSQX7oUU2DalHnvVYc6cyM
	 Uougnw93g09EVNpCUNywqBzFgkIBN0kijQamny9rMDrLTqdRIPe6A5SCaMwcZxEu3I
	 zNZsfy0KjXa8KOIvaqsNItCYyX90Hy/m6vM+qBu8a2Zfw8ZMw0UavYN7+e2S7ICka7
	 eUY/OHB9v8LPQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org,
	mst@redhat.com
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH v2 2/5] hw/cxl: Drop Back-Invalidate from default CFMW window restrictions
Date: Mon, 20 Jul 2026 16:32:39 -0700
Message-Id: <20260720233242.901544-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720233242.901544-1-dave@stgolabs.net>
References: <20260720233242.901544-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default CXL Fixed Memory Window restrictions advertised host-only
coherent together with Back-Invalidate.  A window advertising both
simultaneously is undefined behavior per CXL r4.0 9.18.1.3.

Drop Back-Invalidate from the default, leaving device-coherent +
host-only + volatile + persistent.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/acpi/cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index f92f7fa3d558..75edb2c0a652 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -172,7 +172,7 @@ static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
     build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
 
     /* Window Restrictions */
-    build_append_int_noprefix(table_data, 0x2f, 2);
+    build_append_int_noprefix(table_data, 0x0f, 2);
 
     /* QTG ID */
     build_append_int_noprefix(table_data, 0, 2);
-- 
2.39.5

