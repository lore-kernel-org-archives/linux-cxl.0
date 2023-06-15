Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD27EB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 16:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjFOQQW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 12:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjFOQQU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 12:16:20 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F95B1BC3
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 09:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfYE59+x5empOEgSkey9mX17cliQHb0ttSC0G6wCGh2BtKEcbRedVMtJnmqaVAIyQH0VJTz2IZmtnLuhDWKWYwUWTbyc3kxa/0AspwSci3esbLMOrZ+TuUMpfNg3960lO1rdjIqX+SSzGtiFZWREZi/aQVezfrQ7rpH0kPh6Nc2D2lD+ehOQAg0FrbRoAPDIvGPNCpBgO8UJT65Kl2cuBcBxp4kgXxMeoeITb8BGQc4EXWiPGdFGUxtbOxYgRY68jqfBIwQwdf0TKj5mQ+MDtS+nTdQX1RQycyX1x+Qhju+r3cb3dk00Oeraz2OPrKSKoR+g+WIiDXsic+YVCl20nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gc//pDDuXzeHtV9/pl5Kxhqp9rvVlRYNUn/p08/f0LI=;
 b=jJVEKVSyRr1Z72WKkzWRY6Xex5kWPkICn8RMrkNaBWOQk9qxTRRIhxYUMfKKEvJJ3Q2r+e3ZN1a62jt4L233sF4pytVO2PKyVcOdBEZfEUK/57ETFHt8DltBfiy1Xw79GHHCl/6tGi7d5KwF1Odz7bzJJZfInO9+aQhnPK8UFYf1Vu1Q4c2P5hMZh3cWPWyGwRtOU7U6F34Apvz7bv7frmaP8Ir5pbulJWrMhfGyP2332jo1GQMgXYZJtVIYUZ6uSycHtGXMvJHHhbiK6QRnJJH9wbBAUeedULVjyXB3x7rx/xeN1VwPf94+s0f1/SVvyKUi3ztng7Gx3GbdQcZsBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc//pDDuXzeHtV9/pl5Kxhqp9rvVlRYNUn/p08/f0LI=;
 b=ksL1t+ff57FDPh3ZY/yZIlDsXiik6WMVnbmgyeQ5wyFvdZjG4BGEWleJ7eisGhOeXB8/0aIcBdd2jKpM8YSfhBXI0B2ntv8Qbo7Pv01nOfe9sQE9llhVrbcZ7AIl860ZXhVO9NnueEPw+g8d1rMcEd+thCM2G91bWJZ+FQXuszE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CH3PR17MB6571.namprd17.prod.outlook.com (2603:10b6:610:124::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 16:16:14 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7e82:eb7d:47cd:2ebc]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7e82:eb7d:47cd:2ebc%4]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 16:16:13 +0000
Date:   Thu, 15 Jun 2023 12:16:05 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>
Subject: [BUG] Root port fails to match with port driver on non-RCH topology
Message-ID: <ZIs5Ra+9SGGbUZoZ@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::10) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CH3PR17MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: 261ef3e5-d1ec-459e-ffe5-08db6dbbd6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //SQSb4OUjxVOViVMP2IeenluTfvQAAY/NLuDV76Cx8ywbRJuZTCbXawIPZS9uzpI/3MXNiZII7Hly53mEYPRbjE1yH8PKhkyqGjQ1HN1MzcsQHUSygBZgpjtESnpBw4lROsJKTc1wim5pz6ip1THnonBfKHjRUUukcAbnbCxOVhGq5Y+WBmPWL6ENP16QIzZFUppeKRl0cz1f9O0viom2b+zmQ117+pHkV6weFSkkN7xhNvYJ9NRQrBAhnDo3cpUmJT+8lOcv/JLmSooBGUYRrJQY9yaWpvaznHcuOmm8Jjz6J+NefhXKKf/kRX5CTjMjISPbjKNbrYtXZOJQQWwMER821+A/SeCj37J2vCv556nNgb/H4L4eijLpdCG1G6hBP9qcgrBaU4/fu8lc9uICxgHe+tp15ggygC6e2BE2ZiP32A+w0cDwMOggV753hE2TJcD9I4AluIKKL5tPuXWfXrY08aNdown5RSbR7VkVosRRNWviGyRkz5qjhG22YCQIobZxyPy7k3olwK9oIseI/cOWZ2ZLJ+FUyJSY9FI5QjyrDAgJA3OqY5Ekk+lq9gy2KFaVN20Vq0BvWxI0e0iJkDTnPr8JLuJN8fudH0KGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39840400004)(366004)(396003)(136003)(451199021)(6486002)(86362001)(316002)(6666004)(8676002)(41300700001)(26005)(83380400001)(6512007)(5660300002)(38100700002)(6506007)(44832011)(8936002)(36756003)(66556008)(6916009)(4326008)(66946007)(478600001)(186003)(54906003)(2906002)(66476007)(2616005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kIctDkYbIplX57yRtUPyMd/l17zDClvx4PfFbpq0uD1ou0wu09uk66LjLHLm?=
 =?us-ascii?Q?mSgOyT9IUtancixbai9x83LOsfFIqDSnHJjlggmQZw7w0kb0J8ukmwQ8ZW2N?=
 =?us-ascii?Q?WF40SWnKKOWRUoedhKOkoF7FP4+F1amB2wyOOnSbl86IR//yUmEKUldYEu8T?=
 =?us-ascii?Q?J9NDAqK+Gz5005UsRHaSul1hNj7jhRSPEiVQXjCT4rS6wgx5ESy1Qap0frU/?=
 =?us-ascii?Q?L/a8qLhZ83WB/cyWsk+wwi82y1/87ncIzdkoatAJ2kaxJJA0D339tMXyx+be?=
 =?us-ascii?Q?gdGu2EUPAgPY3JQlWF1iNEbtEZSifLRFUGr+mcwMi/2Sv+naoh1MkdUHlTQz?=
 =?us-ascii?Q?2bco5kIvxX1Ck6qP6znlUPiKTq/QqSTQK1FIFzGh9gZ8f57ALcZ1saMQ0T7s?=
 =?us-ascii?Q?1zYChMsc+R+iY0jQ+3qGxiAL5iHKl1moNH4tymqu/K5+Q85D2asJP5wiecSG?=
 =?us-ascii?Q?2w5ojHA2C8r/SYsyzGgvjdCNr9H2SWBWXfHK0YGargpNpXw2Fvnn54r+s0Cc?=
 =?us-ascii?Q?pSu93c81uvqwwgkO1oru4J7B56FYfBgq+8q1qELyHXFOOw3NajJ8cUOp5xQj?=
 =?us-ascii?Q?q0Cs5xlgH55rNMu+hGVgW5SyRQ6noEHaGCgfTLWFt5lgs5+HmT2mVEUfzRvZ?=
 =?us-ascii?Q?DLL+Z0TGdiN4uRya+Jvk7D1yi9YNc21wdIoZH/YAT3jiYMJORUDl3416FfjC?=
 =?us-ascii?Q?HCKotobJsXqq8Yiw3sCzcmavSAMkRhfAVqhV2INnGZlUyLCtgca/Fq3/esNu?=
 =?us-ascii?Q?86saqokmNW4hkvMavcJD0DgMlke6lgSWdkA5cyPNIT4+chljdtvYPv5zSf7U?=
 =?us-ascii?Q?WOPII4YD1O82iyzW8NWvvGGix6yYlPSFNJ/KHSdpPXpf97mS1ynolXM8NGtw?=
 =?us-ascii?Q?LwUIxpd3CeQGKWY6gLqJPKe1itAa4VfP55RChT2KDNx6krwFzZQYpAvkbdMA?=
 =?us-ascii?Q?ddcl/hLSigPLdJwqBfDcNlVVM9URmd8l2+/oCTYjRrPGgDbSptJiBlqTHipq?=
 =?us-ascii?Q?NQQCmillTjXt2eut53oz29s6cITMt65gEep+HdZSQ2qwW8+6rzqx4FDL8Zf3?=
 =?us-ascii?Q?RINGcUKqFy7Z5geMCHTGXktpnuzbCL9ICPRKiRCsJ7RPi9AY0QwFBbFCCwYi?=
 =?us-ascii?Q?N8YUbNw7IAXEnS0kga4PjwjC8pXfRx82aTuFnBku0E+1RFyEjjqCksBhynQh?=
 =?us-ascii?Q?+M6uJ48a7ELGEFWdoITdydJDRRXkkc4keuIS6PX5On+jd0jvDn15MMJcpsms?=
 =?us-ascii?Q?KJOqsm7ESie71X+nNgo5Olhq6wzz4czyy8KGNY6ynCAoOigomP5MLjNZq+df?=
 =?us-ascii?Q?QdQXaeA7wRrvhMFFaHWWq9IRf5X7UK+Aa4VX8XUlULbK7HuqbSCbE3BNnAqC?=
 =?us-ascii?Q?c6bSBNN7N8mj7ZE7ZY7xoP2zip9OjaOLePJ3nI73xEimU+Fyq8LfJrxZgRJk?=
 =?us-ascii?Q?D4J8jeT5ekQor5vXS/VmAWaDfHePOwcidgz16Y5o1GX9rguocoahB1XzHaiq?=
 =?us-ascii?Q?8HV3jYQ3z/ERq4dRR31FkWPT6hfgavIJTfxg6ob73scKfYKl1UcLy0e9kMfL?=
 =?us-ascii?Q?iyl9ZML51u4P1LI3FWhfw2KEhNPqf7It37p/4wnHSgfw9DDvI/P+3zkNPDKP?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261ef3e5-d1ec-459e-ffe5-08db6dbbd6a1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:16:13.3356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAyypC9IbdIkR9dwaBH9XDMGXDCoHpVzQyyDfJMFk/TzLgASRpN5zgPrlfKXg9dCEwE+cVdCCatEFzY5T2QHeh0kIYulNGE0Ja6cda3TztA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR17MB6571
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On boot in an AMD Genoa production system with EFI_MEMORY_SP set, the
root port fails to enable port topology.  Notably, this is not an RCH
system, so i'm not sure this code path has been tested previously.


Nebulous message in dmesg:

[   15.589072] cxl_mem mem0: CXL port topology root0 not enabled

A bit non-obvious what is occuring here, this occurs during endpoint
allocation, at this point is cxl_mem_probe:

drivers/cxl/mem.c
static int cxl_mem_probe(struct device *dev)
{
...
    if (dport->rch)
        endpoint_parent = parent_port->uport;
    else
        endpoint_parent = &parent_port->dev;

    device_lock(endpoint_parent);
    if (!endpoint_parent->driver) {
        dev_err(dev, "CXL port topology %s not enabled\n",
            dev_name(endpoint_parent));
        rc = -ENXIO;
        goto unlock;
    }
...
}


endpoint_parent->driver is NULL.  In this case, endpoint driver traces
back to root0 not having it's driver set.  This occurs only when the
type matching fails:

drivers/cxl/core/port.c
static int cxl_bus_match(struct device *dev, struct device_driver *drv)
{
    return cxl_device_id(dev) == to_cxl_drv(drv)->id;
}


As it turns out, this can never return true for the root port.

drivers/cxl/core/port.c
static int cxl_device_id(const struct device *dev)
{
...
    if (is_cxl_port(dev)) {
        if (is_cxl_root(to_cxl_port(dev)))
            return CXL_DEVICE_ROOT;
        return CXL_DEVICE_PORT;
    }
...
}

drivers/cxl/port.c
static struct cxl_driver cxl_port_driver = {
    .name = "cxl_port",
    .probe = cxl_port_probe,
    .id = CXL_DEVICE_PORT,
    .drv = {
        .dev_groups = cxl_port_attribute_groups,
    },
};


the root will always be identified as CXL_DEVICE_ROOT and can never
match the port driver.  As a result, the >driver field can never be
set by the device drive base:


static int __device_attach_driver(struct device_driver *drv, void *_data)
{
...
        ret = driver_match_device(drv, dev);
...
        driver_probe_device(drv, dev)
}

static int driver_probe_device(struct device_driver *drv, struct device *dev)
{
...
        ret = __driver_probe_device(drv, dev);
...
}

static int __driver_probe_device(struct device_driver *drv, struct device *dev)
{
...
                ret = really_probe(dev, drv);
...
}

static int really_probe(struct device *dev, struct device_driver *drv)
{
...
re_probe:
        dev->driver = drv;
...
}




Unfortunately, I added this as a hack, but it did not resolve the issue.

I'm a bit lost in the device-driver core trying to track down the exact
path that is being taken, it's possible another subsequent error is
occuring that subsequently fails as well.


~Gregory


diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 4d1f9c5b5029..7f99e4f790d8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1853,7 +1853,9 @@ static int cxl_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)

 static int cxl_bus_match(struct device *dev, struct device_driver *drv)
 {
-       return cxl_device_id(dev) == to_cxl_drv(drv)->id;
+       int devid = cxl_device_id(dev);
+       int drvid = to_cxl_drv(drv)->id
+       return (devid == drvid) || (devid == CXL_DEVICE_ROOT && drvid == CXL_DEVICE_PORT);
 }
