Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="qb1QduTs"
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FE5CF
	for <linux-cxl@vger.kernel.org>; Mon, 20 Nov 2023 16:38:25 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BA2667A2A1F;
	Tue, 21 Nov 2023 00:38:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a230.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B58A67A2896;
	Tue, 21 Nov 2023 00:38:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1700527103; a=rsa-sha256;
	cv=none;
	b=t8K9rEmooo1y6w7t3pHROUlaDZh6oJViOuY0AITIHRxNYqwnB6ylDAsm++0tP0xXdDUgoe
	SCKdiItKeq61Waz7a7/a0n0VvtMldo1KEBkeARIno6FCx2uDL1NBJVhY342yLydTOIk0qW
	xdXP6k6h7jFE1dxHaIfTIwLfbiNEx6lhOvp+bmhtoQcdjPuKulCMBJL0Kr/PP13tptbeLG
	hLXLO91AEWYx/h0e9V/lleKe6kdjxfWJTBoohqJa1hbfyQ7ubdFmn0sWpmTJVDsdPi4911
	qojoHsmLxouqvTxLkSjk2jS46h9KjC8r1dOhmP9H3f+7M31PIEsuFOx+pyi9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1700527103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1NLIYBZHY7cPwhLhsgurCHjnocUrPQCjVm5pP+PxtZ8=;
	b=cBhabovjFR15c3tjc7IPnAHqkWVagp2m5V9ma+uJe/DaQ0BY5BLnH/JyVorEUKVhjBuSf9
	XW74zMmeVg0RZm0tCEAg9jlSRS7VDA4gH8fpm+KHdf5lW5uhFoL5QWVrmZoU3Pnl+z5qsF
	wHDOrkDHWIGzi2KQLpHfQr5bFAp82kc+RjrdqsAxYwL3sxvW4+hxTvJIGG65fecf4/d4iO
	opCvhirgHIt+2obg4JAVIQYE2sMpdPRwOWZDfBn1AO5Hcu8DvRSzAdQIeARLofG++/ndcr
	+0apxDmh+Esg8hYq1GZR/viYYNtM5DR1R9dt22tRNA3JU92GaZfiLseQINUjgw==
ARC-Authentication-Results: i=1;
	rspamd-7f8878586f-s5zmn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tangy-Whispering: 18203b295241015b_1700527104584_2010662759
X-MC-Loop-Signature: 1700527104584:60291264
X-MC-Ingress-Time: 1700527104584
Received: from pdx1-sub0-mail-a230.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.123.8 (trex/6.9.2);
	Tue, 21 Nov 2023 00:38:24 +0000
Received: from offworld (unknown [108.175.208.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a230.dreamhost.com (Postfix) with ESMTPSA id 4SZ58H0gmdz4d;
	Mon, 20 Nov 2023 16:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1700527103;
	bh=1NLIYBZHY7cPwhLhsgurCHjnocUrPQCjVm5pP+PxtZ8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=qb1QduTsvsxZbt8uRNg+tZBLTTMy6U/Qtm+9F/ONnk1ol4FSLwFisD86hwDmYyul9
	 u6wlIaYfU08Zayn5KQUMB9AI2UVjd06Lhng0HOITpSh6NhJ3rPDJAbJkidbXIqelAy
	 jPHvJ+2fNHYt1duV2pPk55c5y06A8OiXuUvuWmVEGE80kTho1WizOreZJFiZ1aqUmg
	 j0C5cUH7mRYtMYFgm6GyYPixGYmMWqfoGdkLeHRNbIMeEfDfhVpqX5IDVSiLyvKPbq
	 NJNk24UVBjMIeVY6BnpkAFqgajtpUp62qup6PWu2OWXapJs9qalUAEADrvgFtzFN+h
	 iXBa+lDdGlS6w==
Date: Mon, 20 Nov 2023 16:38:20 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: shiju.jose@huawei.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, 
	jonathan.cameron@huawei.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com, 
	linuxarm@huawei.com
Subject: Re: [RFC PATCH 2/3] hw/cxl/cxl-mailbox-utils: Add device patrol
 scrub control feature
Message-ID: <vjd2xgizy4f4sjsbjfksjhnrzshd2o24ya5k2xrtvcf36tpi6s@elfrgj2q6eh3>
References: <20231114124711.1128-1-shiju.jose@huawei.com>
 <20231114124711.1128-3-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231114124711.1128-3-shiju.jose@huawei.com>
User-Agent: NeoMutt/20231006

On Tue, 14 Nov 2023, shiju.jose@huawei.com wrote:

>+        case  CXL_FEATURE_PATROL_SCRUB:
>+            /* Fill supported feature entry for device patrol scrub control */
>+            supported_feats->feat_entries[entry] =
>+                           (struct CXLSupportedFeatureEntry) {
>+                .uuid = patrol_scrub_uuid,
>+                .feat_index = index,
>+                .get_feat_size = sizeof(cxl_memdev_ps_feat_read_attrbs),
>+                .set_feat_size = sizeof(CXLMemPatrolScrubWriteAttrbs),
>+                /* Bit[0] : 1, feature attributes changable */

s/changable/changeable

>+                .attrb_flags = 0x1,
>+                .get_feat_version = CXL_MEMDEV_PS_GET_FEATURE_VERSION,
>+                .set_feat_version = CXL_MEMDEV_PS_SET_FEATURE_VERSION,
>+                .set_feat_effects = 0,
>+            };
>+            feat_entries++;
>+            /* Set default value for device patrol scrub read attributes */
>+            cxl_memdev_ps_feat_read_attrbs.scrub_cycle_cap =
>+                                CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT |
>+                                CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT;
>+            cxl_memdev_ps_feat_read_attrbs.scrub_cycle =
>+                                CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT |
>+                                (CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT << 8);
>+            cxl_memdev_ps_feat_read_attrbs.scrub_flags =
>+                                CXL_MEMDEV_PS_ENABLE_DEFAULT;
>+            break;
>         default:
>             break;
>         }
