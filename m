Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB71EB64DA
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 16:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjFOQlp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 12:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjFOQlU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 12:41:20 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2016.outbound.protection.outlook.com [40.92.53.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39722684
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 09:41:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nf3GFOpXgcJCLKbyyHGTJ6UCsbUkOKt8VTZm1ucu0d+AjjY5aowZUc56V4skmvYr7A6PFTpT7fwBL/ErRix32AkrOrCMnVA1hBVL9SMxhsct84S6HzmspxAUIHV3utmhxNaQDjPk+iElHNCR2ZmDF5UdV39TC77hfHTY3n2TmtSISGyIK0St2teXSoVXRdOQ9GReXTYibsUosPz1ofODRUCmaClOBmicg0umd5xZqLp6HJz7P7go+Lz3rlopNloGC8Ho9PYyrBWOno3dD7azIINkxBrJ3WgsohZbm0QtzLEwTcazC7Qsxc9aJztDUZasfcqUEkgmq5OlVlJuQf9GRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hkSORP1zyY6xX/NQ4djjbShmqZm6rbjyVKvKd5aEY0=;
 b=M0PX21qDYmPTNjJopW+8AWNw09SELpRWQav7PVugYdokVkgnbecXAdW2FP33070qDOcA4M/f3npkKixGLIOvakl4wKqQFhJVn0ZcQwOui28C22TpWxSp8knh8iNLJKbW6rcGFONwq1iBCZx9Hw5naQFOe6xgAs4w/92M728HqVkMqvYyJYOhqEvrhgE4GQivjWQUY8Q2xyIfb+9fhqKmGLT40TfxOsv5W6+UZ8WVg308oS3eol+6OSpO4D9pm2iBdrpRa20pCf6bRJQzYduulSuTTomSyWzv2Kks8zz5L1uHJ5Oo4neA6gKZJ3d59+IPe2B3DrK91d8aZqoI3YS+qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hkSORP1zyY6xX/NQ4djjbShmqZm6rbjyVKvKd5aEY0=;
 b=WO8z/jOujbPOrDJ8maYGLUXWNhPMmbIRPFOZdSVtIBKAJ22J4xKlM8/avN9UhOZGzvAqxoOVLWDqXRyIFy5G+Rc3/C4vF6eXsSGCPLZu1EceKUjEziRr56Os33l+wcw0nzISxrq6V1Pz4fwccuxWy5agqUZeUzstZGf0xkU0bOtXUeKkeQd7EDji+c26WMPmJoyeX51leA3yP7VfQDFvu8iTsHqmWszFyhbGI1K1+L3fBd1pKxupvVhBuyD62brCJpr+bqVtC0LYoLcp+WNpU4fvrdJnOBhZkdmkEhqLe1a69th6UaYcXmuCe7mqryv7/gkQDQhowGKznWlnMUQbmw==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 TYZPR06MB4479.apcprd06.prod.outlook.com (2603:1096:400:8e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.37; Thu, 15 Jun 2023 16:41:16 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227%4]) with mapi id 15.20.6477.028; Thu, 15 Jun 2023
 16:41:16 +0000
From:   nifan@outlook.com
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com, sunfishho12@gmail.com,
        nmtadam.samsung@gmail.com, nifan@outlook.com, fan.ni@samsung.com
Subject: [ndctl PATCH v2 1/2] cxl/list: Add parent_dport attribute to memdev and root port listing
Date:   Thu, 15 Jun 2023 09:40:49 -0700
Message-ID: <SG2PR06MB3397659499664CCFB11DC404B25BA@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615164050.3248000-1-nifan@outlook.com>
References: <20230615164050.3248000-1-nifan@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [15//rZr0KNFo9bH2dAZ7nhIaYnwuctex]
X-ClientProxiedBy: BYAPR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:a03:60::24) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <20230615164050.3248000-2-nifan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|TYZPR06MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: 2001dadb-745a-4ef4-932f-08db6dbf56c7
X-MS-Exchange-SLBlob-MailProps: EgT5Wr3QDKzwu8YPsqYDy7f7AA4ui0PNVg22DAedwUKq8+J0oP8puSdR/YfJr2LdFFiirvwTdlyoPESz1wLFsaNOhaK6taLkQ/oBT0FhWDCpoxjPnacishpEHii8f1bccoFPAzESkLxpulk8Th4NIOGtP2Ngp8yl9mq6BGyqmY0HLhWYqEb27cmk4bTX50askQb+BiGYQF/3ekZM5tuoCxa7z452Kbo5Qgw3lxWJPrc+8X58dMXbj8LFcNw+bRpEy20kiaRNB8ywFPBwHAEX0QJnbYbPgwB4IP9+S7VSI7qgsIGY0VZyxZbp+shKJwKskPEtccLuW16PvhFTFULM9xit33E1guWUHzNrS671625QkVlFiJCKs3ai+ebabJjBEgSbi/Cy4qeUa5pOkLEw71Q4V3mew9pCKz66S0NUu3IoDlfvzfuHZ99BjRhpV31owlmRNFheBTWpEaA46Q+JRdzcSp4T3lz1z4bsvrC70g5nAZolfq4Ccl2rXZYd8C2xQfdu4HF9OwvnyEH+Nqh1YrWcdRvGgxLSGpM4fKfdqQXtN+zRDEwHo/9cbd+WdWoj6c7Q9RPR+FXja7y0h9bQMuIVB/8Op4/KS9Ed28uLMCD/7Y/1eCFtPCuMJzbjvLjLPFjB1812XpyiFJkSBrotNoMAdVV8ODtzvKM6PljupkSFc0CzBFXuEuJpbpd7wbjioVnA4aen4Lp7Ip0Yei0fSdl1rK8POsvkjZH67SwOSMk=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /4eVjhf7uGP+aoV7h3YMWQxWex0PoJi6Mg6rLi9PmEff9ksUD/sHfhrExm9IftrZMrv1cke9ujbXqXatIrejAh/SLU4ENRdlfoV2PVwt9wmzd+Vbe6itnELQezqaQLXSVc9J87A8G578MAw5cDUqlKjqTqOFG4MMFpjDEW+Irm+IuvHrECw6uJmqH1n9WCRGIIKymyryUQ6Z88eLj/TJeD4+gHcFtPXDJFztlcyqobmATQ4CeE2KAmnMABz4VNOMX7YXKiWKLG2EPnn0Dd8zMMQmKSzk5DIxm4OTmtwyUEMnMQ5Wt5181helPRgHP3zRzyVhax7ntjc+1cvO7Joh8TixFhMQNOweykpgCq34lVavTSUqrb1cgU6ujIqI47PKv+E+EgwrsR+RkY9/ezU7hiKtvfnLedqLUUV1A4veiD+s0vGOXJXFSlPNr3Ue2OBmQMfFLw2cOCR6wckzF/FXuurNZieXUdYrMOBEPT+11WtC+4HwqBQl2OF1O95z8Ad225KKN4Xkh+CN+Ecp5JrQkxtzFhWD7VSWw45IiY2a8xWLiVUCnH2Pm5OGLOIoVVqVYdYjQCILoxoC1OawD6pq272TYKuzbvE1nIH9CqDr6YQMeFC3IFoSHeyKErD7w317
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kiK3ryTx70yxa3QDSL7lLlKHAVazB899m7EZ8OMcZoCavvi+MoGgsF/c5tcs?=
 =?us-ascii?Q?XJ//zhP9Js5qJ0etnyBzD1UemDpzOheMKW1cs06fkLO+BXMZ83GsZTFrK8og?=
 =?us-ascii?Q?o5bQQtaqC9aZgBLgQBBh0ZmWK8ka0/zazVa9Ox1EAD+L5hZqykIYfb5ywLLd?=
 =?us-ascii?Q?a9DaIwN2YTDkIzIyz7u2kl482K+h9lVdQOvk0Z6lwpCooOCwNF6D7XH+/MUd?=
 =?us-ascii?Q?UGIR64YI8IqsfGX+d0NH85VGUfKqt4BGjhUZG29K3SIpo0G+uKgI9VpMtEnd?=
 =?us-ascii?Q?Cl2/ko3oYYA1L6lvfCv2hhoULuQhzGJCWXy3/ttYfiARibE6zYhJujsylbqj?=
 =?us-ascii?Q?pIRhh2l6SKuyIQS+P5cPtFyjjUFTDpv7m8UPBrhzxcx5GkXPok70qFp52NNA?=
 =?us-ascii?Q?CRT2OKIRwE3Jw5GVBQkUU/acHlsYTz1qjYmrIRKbP0e3mVVv0UCKFqWinicS?=
 =?us-ascii?Q?hGabg9PNvtPVcMQOntDBd5ERA15Yqa5k7sExQb9/nnCZX3k6YAvopY8aHye5?=
 =?us-ascii?Q?6OXdC/sZJ8MKS5qWtWLQ2JLieCIcvWuFJGoKUXqERltvALvTsbiUXGdsRjA6?=
 =?us-ascii?Q?An1l8dpXPgxxdrM1NLPxXWUbwMWfmBTFlWS/B+bdCNS2eepLlOMQ3jxJkLq9?=
 =?us-ascii?Q?Yt40Eo0Kp7YZxz3GOTDNBrd8jFPHwIBi5N1VcRrXY9cXqmhLpkijOqBrKmOV?=
 =?us-ascii?Q?oAodAU+vBK1dqtkdd7mkKbot+0bm/0xxJ6c4o47vFmNc4ngNKfjQLcAp77SZ?=
 =?us-ascii?Q?BP1YeSKGUbwqz9+1sKyoMMk5LN+HbR8y/1UFWtGZT/ydccz1AdKAZ+xyTpTr?=
 =?us-ascii?Q?23FleBgACZCoi1gyyDRtb/Es5Ff5dfmOQQTII1fIiClj5fIpdbga10yygERc?=
 =?us-ascii?Q?zSCC+ku/yCSidTbsc1wZjhzoXRnLtiD2xCNFohWVHc2DGMDeKKLLUjNPqJG5?=
 =?us-ascii?Q?0/KnhSuvSnGDwUik527uplsYYHJIGxxFfHP7TZrgXswzlkV+KsAior9WbjqX?=
 =?us-ascii?Q?UKfKm7OOlT5HXkSdBKyTNgMl4o9+X851Hf7/5Fpz2MXC6fwjoGccTY47TeWV?=
 =?us-ascii?Q?3pYt1vkAQjalJsHp2FrCQ2ShsGE7jE+X8fFb6zhtUg9cY2at28HwIG2CkJA+?=
 =?us-ascii?Q?2LnLJFMITn9HFcqT7Bkbr84sJ7/5uhXasIEHLT7Ls9VGrIikwDbxLFbQBW0y?=
 =?us-ascii?Q?r89ATcrMFrWIhGFg65Q0D/HLq+Gi2xtAaMd/6A=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2001dadb-745a-4ef4-932f-08db6dbf56c7
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:41:16.8541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4479
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Add `parent_dport` attribute to memdev and root port when listing by
leveraging cxl_port_get_parent_dport function. The attribute will be
used to describe the cxl topology when plotting cxl topology graph.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 cxl/json.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/cxl/json.c b/cxl/json.c
index 9a4b5c7..f7600dc 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -540,6 +540,23 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 	if (jobj)
 		json_object_object_add(jdev, "host", jobj);
 
+	/* add parent_dport attribute to memdev */
+	if (cxl_memdev_get_endpoint(memdev)) {
+		struct cxl_endpoint *ep = cxl_memdev_get_endpoint(memdev);
+
+		if (ep) {
+			struct cxl_port *port = cxl_endpoint_get_port(ep);
+
+			if (cxl_port_get_parent_dport(port)) {
+				struct cxl_dport *dport = cxl_port_get_parent_dport(port);
+
+				jobj = json_object_new_string(cxl_dport_get_devname(dport));
+				if (jobj)
+					json_object_object_add(jdev, "parent_dport", jobj);
+			}
+		}
+	}
+
 	if (!cxl_memdev_is_enabled(memdev)) {
 		jobj = json_object_new_string("disabled");
 		if (jobj)
@@ -1009,9 +1026,9 @@ static struct json_object *__util_cxl_port_to_json(struct cxl_port *port,
 		struct cxl_dport *dport = cxl_port_get_parent_dport(port);
 
 		jobj = json_object_new_string(cxl_dport_get_devname(dport));
-		if (jobj)
-			json_object_object_add(jport, "parent_dport", jobj);
-	}
+	} else
+		jobj = json_object_new_string("ACPI0017:00");
+	json_object_object_add(jport, "parent_dport", jobj);
 
 	jobj = json_object_new_int(cxl_port_get_depth(port));
 	if (jobj)
-- 
2.39.2

