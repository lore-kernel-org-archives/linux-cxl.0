Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98812F25F4
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770059625; cv=pass; b=bLy2JGvV8VW/6j3yFQV1kA8PHPRxxoiZYNoeweGY4LtBNK0skexB+4I2kp0DTSOtkBBJIEO40mWQOUorXGL9JhWn9IqqixHALMWgknl72tt3ozpdfyByQSYEg2U2V07hCccgD0LGNONB+vMvbobs6p+icQDKBV+jNKkVSVhfwN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770059625; c=relaxed/simple;
	bh=GfHFW4IC8M6FrPpmvZaMu9frRH8maXbIIQaSkf81+as=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P97WMh0hKloB9SwGjttvzEDwuG4jDp2fGwqPOMFnFBsNIsQELlgXJZfwWVrb+2wuA/vlQFYR1EGZL5Ro2QUyG7JjVeuHWK91JlFoEReG4B1TVDMSzxifUeq7nPS7K6dENYTpEAH+U6NrQI3MVrLX7J1SnQTm/FRGrHuBDqszRyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=PTN7hJ7x; arc=pass smtp.client-ip=23.83.223.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="PTN7hJ7x"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 95E06182770;
	Mon, 02 Feb 2026 19:13:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a252.dreamhost.com (100-123-122-168.trex-nlb.outbound.svc.cluster.local [100.123.122.168])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 24A3C1826A7;
	Mon, 02 Feb 2026 19:13:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770059617;
	b=3SwRG/LY0nkSCTFJh/w6UcNbBvtPYHCm+CoiGl0gLSIEI289WYAVTjmfnKCNtR9LUKLf++
	8hgcO377Us/vUigI4+6xUBW7t3nVP8raWc/4musNRGr2os46/dmPrCS2TTxYBpKP+XE43H
	to7B28JZvzHS7saJCgBL060XuYtfvOlBASivx3+DbZO8fBoLKjKQWb2KSrLyuqXux2axY0
	HEyhfPzX25oCO7L3xFnGCz85/Jnp2eNo/Id2VhTZtzIGR7zibqPM22vHJ+ACw7ffof9uAS
	ttfMot8i8syJC2e91GNaVtH59GW0xUuBEfsypwcMlZErrYKJhC+I5DkCk3XxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770059617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=aoXhQjSW3EvO6oX64PkRMGBX0VMzW2JjGFbRgk9a5vc=;
	b=AIGN206Hk3jsAbtReHsT1XTTGhrccADFY9d24Cn06AOqHrbaBnc/Qt4UzM6pFj+bqaR/0S
	tNbClfWXm5Ot/GzBlRi4XKXbm56semzjY5H5kkUSUp1pTy59f7fvwDOHFW6WAGFtUMW5fO
	NL+UuXkWWPa3F2I5pec6abb5QejkcIC9uU3sVNzGui1bgIBAUG5o65DVTqKqFixdi5OQwL
	VXki8/QXoXoeKaLg7a2upWwssoDwiFvg1b5Sp2emnJEHq+6Ak4oeCn1VL3cDxfGisYxMwt
	3cpLLfSvisJrSXE+4lhUhbY9IMOtW5DJvgv6IVMUbLxPZOAFrQvdlQ7jU/zwzg==
ARC-Authentication-Results: i=1;
	rspamd-5b979ccf89-87p2z;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Squirrel-Illustrious: 5c501f83464b5ab3_1770059617401_160547041
X-MC-Loop-Signature: 1770059617401:1360243272
X-MC-Ingress-Time: 1770059617401
Received: from pdx1-sub0-mail-a252.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.123.122.168 (trex/7.1.3);
	Mon, 02 Feb 2026 19:13:37 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a252.dreamhost.com (Postfix) with ESMTPSA id 4f4br03TyTz105C;
	Mon,  2 Feb 2026 11:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1770059616;
	bh=aoXhQjSW3EvO6oX64PkRMGBX0VMzW2JjGFbRgk9a5vc=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=PTN7hJ7xSJlTJ9uHMTExEPY7Bes/CpY0pMu7rjMbdJgiWAxgMpXEldTkrjgxZezVq
	 J4hlnckB8Oq+yDB20p/wJy0tr2tZRl+iCW4IXjZGjIugLFm/m7IFrjSYPLMP4MyQ47
	 2Fw1QvOtfzykfu3aJcFKOSmurpZCllbOxxWKgLqE9Of+fOtPiqXRMRchs4fAwvJ7g/
	 rQWYuvNsMSIDZe7Z7tbMsDSqDSYywtOcV/5MqYZY9lCxgERAyOhv3s56fvo8QtHpVs
	 HO7FojIKZqZH3dLHCXLTH4+zDhs/aCXv3LRMNB/blE2PSTGydHfaOXcmHC0DbS8GwQ
	 hhOpV8Drlup7Q==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] cxl/region: Fix leakage in __construct_region()
Date: Mon,  2 Feb 2026 11:13:30 -0800
Message-Id: <20260202191330.245608-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Failing the first sysfs_update_group() needs to explicitly
kfree the resource as it is too early for cxl_region_iomem_release()
to do so.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/region.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 96888d87a8df..28d70497283d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3795,8 +3795,10 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, &cxl_region_group);
-	if (rc)
+	if (rc) {
+		kfree(res);
 		return rc;
+	}
 
 	rc = insert_resource(cxlrd->res, res);
 	if (rc) {
-- 
2.39.5

