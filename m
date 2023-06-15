Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AF3EB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 18:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjFOSqW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 14:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjFOSqV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 14:46:21 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A511BF3
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 11:46:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoY3NZ7+0VA1K6Ac7SfQZpiKJabDwv8VgTTy0Vl2AOPwbAP5j75v16Zh11aFmn5I2ay1CGymUON248P3vyxhaP81a6Iqmk/9EOokneh+gzUo3uJOU7m8EJXcS+wiCkjBTA8Pk6X/n3Ll2nd0AE/QhhfbOaChrFOAGuIJJVx60DqPaqig8vN+vA/E03kyKGJ3u3Jbbib+D4wW9wBMyi3uNLEBFkrZ+T83vZGnjjky99mNe5hYQ1fx8j+HJo5i4B2/O7Nx9vzo6CJOSy1ZDnGFdo/UcQHrwkjjLry8De7tQxUM8w9uXwErgpgVQHB/NUIrjVW86Htx0w8I/gDSDYDpcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bWJ/+hxoSf/ZRmfrqyWqiuD1c+C4hM6zE9zQ5u9OgY=;
 b=k8fd7lDHXuv2PYzp3rKYWEd5wDsRhXHjSxTHSaMruLT7L03XCZHbMBK7Gei2OU8r0Gju8qyYT/alw+brNco7dRkygAVEoMXbvlZsWPr86+5ULfkj2gSeQPWqePhEYkc2P4btxdU98Mq8ysPvgJKruqL+aDQnCst1Kdcy8IevOqM1f7bfE9kpybHGgl/Hxz3CylOMheKpJ1Pk7yNXg2edFGl8d8vfzVHP04mPewwjZ8cRGzKvvL5aG4cZHdRNygbZbiWEV0qHuIwEL7ZlRaErBSk7cu0DEKCT8vexNTZ4cCqZaWGSJT1wqohYqWC8o5sNxGHyzdImuEm5iQewCAchYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bWJ/+hxoSf/ZRmfrqyWqiuD1c+C4hM6zE9zQ5u9OgY=;
 b=yExMHZFvOaQQCprImLl4VRZb8ZiSpLUChU5+9BwwIKj3bAyPVt4sCAVCWIHvCYC+DttOcTznBxiV23IDQfacYyjbkvnBn3RLm3yMhG/5Sv0+KlM3EJOyNiQOspYYP8sCBsr5StAqyrX92PIGtPtGZorPtGF2BkSw6P9H48SFBlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB4255.namprd17.prod.outlook.com (2603:10b6:a03:2a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 18:46:16 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7e82:eb7d:47cd:2ebc]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7e82:eb7d:47cd:2ebc%4]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 18:46:16 +0000
Date:   Thu, 15 Jun 2023 14:46:13 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [BUG] Root port fails to match with port driver on non-RCH
 topology
Message-ID: <ZItcdaq3j8kW+/Sy@memverge.com>
References: <ZIs5Ra+9SGGbUZoZ@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIs5Ra+9SGGbUZoZ@memverge.com>
X-ClientProxiedBy: SJ2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:a03:505::21) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a992a0-9544-46b5-0364-08db6dd0cd1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+VmbhgUbQmw4pHWbD+X+MMPPC5oCsX/GH7l0Rxc/LrUzm6vA802PcISZ7VjtH8zekmPddOAsLjcp0sdhq5f7jOMtrOM/abiYCwddq0Yjzg2vRl8s/B5/f+/cpoOjBVazK8UHRdTcJbvrb4nc3/997W/SaA2Ut6qWQhpKpYCRnOKvMyESTbpQjvQM+OOLDNFS1qTpqBparVK9WmsOufwaAVoAnymWabLbYdARTz7jVuaQdW7egaV8kQ30DDmMN1+AVQYh4Qp7egqQ707LbstzGS1y7ihZSzIbQlLmTEephlGaXcxK9GGQO4r/BmwyKMt1MnGvOtiAZVQtpWgJ/6uQqn8rQVY8rAz9AdI+8FXcJCom7hiF6H2yZhDBtQmsxrVvxivY3C43RJZzJZ6dSxuEHYMwgVxbcx1xDEVF0DVnfFN6xbJ7ff43ES04l2KJn2d64nysGKV6beTcztcmCaOWtVeR2BgaHyUdrnSfjcVbRmrWom21tepNxYUDN3mH+8XVKslufw0oiE+rqH6Mqy/TOUNAz1ecT8nqVigKdEsWFazuxoOM3xXs0mjQLtvrea7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39840400004)(366004)(396003)(346002)(451199021)(6512007)(26005)(6506007)(36756003)(186003)(478600001)(6666004)(6486002)(2906002)(316002)(41300700001)(8936002)(44832011)(8676002)(86362001)(5660300002)(38100700002)(54906003)(2616005)(6916009)(66556008)(66476007)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1g8C66F4zaGhMb+MKu1BRuMqNBTKxIBe3o2BZDbA3z1Qz2+awitnceIntxlK?=
 =?us-ascii?Q?iQhKtEFCdpYuZ8toj5zmMnUqQfE8DguV+TLYFx7OO0uFh0x8HMrbG3c9SgKh?=
 =?us-ascii?Q?XNuVsWHXqbTZDPME5vUGyDy2pykwXym/ZPy8iKv0WGY1ZwQZVRyWgiVYf6mf?=
 =?us-ascii?Q?IM0FYoaI5VI7O0wvttm+zhBHtTYtpB5xG586avm65rr1zFyTPNx9qTDBvXhC?=
 =?us-ascii?Q?B1usMGnKTslfohxYB9Xw+sq3Nq/XvVIjd+kP1TkDzt8euJKEIb5yYrjBIJVc?=
 =?us-ascii?Q?2TlU07N8NYJkH6h54NSyv28GveWG4T9angAPp5LUPpGFLmzRBwTtsIPT4Flj?=
 =?us-ascii?Q?2YC/AvOXMjpaF3aG0nk3rM2Xy+MYUf7eCtXHpzT4/KItHqiWFVG7fo6hpoAs?=
 =?us-ascii?Q?eaGE0uv3bsSZekfuz/JlPuyVlrkds48SeyHarXX1wWifsf3vkByscw/t6224?=
 =?us-ascii?Q?x1JBOSJpVKkdrXfCt66xqjq4vw0z+BPzZgzX8P+re7uFBkrJd7/gkJN8Q0u6?=
 =?us-ascii?Q?oynlblf6KQuPc7kfhO/hqKRmC8iGrq8tKWHeag9KC7TGrJwQoADmBcGdMLCp?=
 =?us-ascii?Q?iHoFTU+2mQLG0HJN4JzUXI5R/a4ZbOSD1mqBKM69YNvFah8MuilzBSQ0x7Wm?=
 =?us-ascii?Q?gyjNnp9NHs6iSKHbRFW+h+3PG5Wa5yesJO06gNsGxv4e6rasOeyFdVSmHwRN?=
 =?us-ascii?Q?c6BNNyoaXk3r+PwUUaYXwNDFv/u2cvlhEPEYhQvI/tIU6tmr1ooj+542jIZ9?=
 =?us-ascii?Q?Pw9OpsEB1RuILDF3kOUNDJ2I+xc5mI3s09SGCjW5G1gNwm8F8O5eTOnCgdL2?=
 =?us-ascii?Q?84fi10CUtcF/3m3+1PfYCE8UBS7jJk8i01QldZfku4WDYoKSDyARvhskV3+J?=
 =?us-ascii?Q?ZwKCyUfZuPYQSdgFV6CK7H7jeCpapNEyAh+KEhjB1QhIvrj9hmdK0JZYNyjj?=
 =?us-ascii?Q?aJBogW2ZdBTq9SD6TKH1SQHIckXOjvHGZC7ZcBDeH8uSNjiJdQZdsDgnGKRT?=
 =?us-ascii?Q?q6Bt3c+g2s0yphoBme2J4RpisVS/C6q18vJvSlktehd/O52bL3+m+d4iZJu/?=
 =?us-ascii?Q?BRk7Df6xwBuIp5yj/dE/FBGbiMENGKYT06jOI8zZ+nQj8kGYkcy/BZ38vbK0?=
 =?us-ascii?Q?3ZJU89etBWmOUb7b3gTJ2q9s/bmqjyFqXGLemwwvYf6UiMBuOPhHbWPhB0m3?=
 =?us-ascii?Q?bjyzg6sNonUwk55TRbXTqTytZYDn1MDUZKDfyx7/yEuH41EHkdVPCBtNgGHc?=
 =?us-ascii?Q?xX8O8iEEZoAZiv6DgkMXSb54UQv6yNJzU8kByFPOlgbyEihjAfDEEUdiMgFh?=
 =?us-ascii?Q?YmtZI+xevzbGIc02Ay6WAPaqXqk5PXEnPNo39VBmzHMOXAS6O22/LbUiw7VQ?=
 =?us-ascii?Q?1BgF9jOn1qAa5a1ETpI/Js0lfDHrymaQQ3QL54lH4QOD9sPePyD1zEjYklk0?=
 =?us-ascii?Q?dYayRd8V96TGZP+ptAL4HxOatpMZzz+diRWnoJgqrmwBOPIGu5zkEo2QpaU1?=
 =?us-ascii?Q?eloKIS2DaoHqARpXA7yDuyZl7k8OjDeKlpxjZkNq+iR/s+M73VkSiPnTKc0l?=
 =?us-ascii?Q?hT5OxRXWcvkZI4LoY/RiNR3WyeihjLOkkiMx+aYXNbsGzonhIg8q/LaIwG1m?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a992a0-9544-46b5-0364-08db6dd0cd1f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 18:46:16.7488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tu/HoRHetoQvey/N85B4oppvzMtHdQDFyV5Kf0gtxuLr5eYhfZpJpt2h++5+ksha/ysDU47S2CG8yUGRa5GkyyX9DbEwwMIgHq7BJMu+H0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4255
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jun 15, 2023 at 12:16:05PM -0400, Gregory Price wrote:
> Unfortunately, I added this as a hack, but it did not resolve the issue.
> 
> I'm a bit lost in the device-driver core trying to track down the exact
> path that is being taken, it's possible another subsequent error is
> occuring that subsequently fails as well.
> 
> 
> ~Gregory
> 
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 4d1f9c5b5029..7f99e4f790d8 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1853,7 +1853,9 @@ static int cxl_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
> 
>  static int cxl_bus_match(struct device *dev, struct device_driver *drv)
>  {
> -       return cxl_device_id(dev) == to_cxl_drv(drv)->id;
> +       int devid = cxl_device_id(dev);
> +       int drvid = to_cxl_drv(drv)->id
> +       return (devid == drvid) || (devid == CXL_DEVICE_ROOT && drvid == CXL_DEVICE_PORT);
>  }

follow up with more context, there is a subsequent error on
cxl_port_probe which causes dev->driver to remain NULL.


[   15.561313] cxl_mem mem0: CXL port topology root0 not enabled
[   15.561315] cxl_mem mem0: call_driver_probe failed


drivers/cxl/port.c
static int cxl_port_probe(struct device *dev)
{
    struct cxl_port *port = to_cxl_port(dev);

    if (is_cxl_endpoint(port))
        return cxl_endpoint_port_probe(port);
    return cxl_switch_port_probe(port);
}


since root is not an endpoint, we probe root as a switch port.

static int cxl_switch_port_probe(struct cxl_port *port)
{
    struct cxl_hdm *cxlhdm;
    int rc;

    rc = devm_cxl_port_enumerate_dports(port);
    if (rc < 0)
        return rc;

    if (rc == 1)
        return devm_cxl_add_passthrough_decoder(port);

    cxlhdm = devm_cxl_setup_hdm(port, NULL);
    if (IS_ERR(cxlhdm))
        return PTR_ERR(cxlhdm);

    return devm_cxl_enumerate_decoders(cxlhdm, NULL);
}


It is likely that dev_cxl_port_enumate_dports is failing, though more
investigation is needed at this point.

What I don't know is whether cxl_port_probe is intended to probe the
root port, or if we should simply be attaching the driver to the root
port device explicitly rather than going through probe.

Any guidance would be appreciated.

~Gregory
