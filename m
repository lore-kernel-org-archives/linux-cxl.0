Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E827CEB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 18:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjFOSvW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 14:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjFOSvV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 14:51:21 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2891715
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 11:51:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEjYVcvkVxEiYTbpjTWaBz+Z84HmlYc0tT5Nm1jgSrPcAeSCCwp9Gr2M9RJUVcDnwzAnoIsQGeO747H04fGJFXQeEw9t1NZQEUnYd5GcH3tB1jcdQFa108TJF1jbdtZQ6HB71JbWwtxrGrkCHzqPVCyyH8buOve56Ssu/wnK9R5p2eR6mSFUzPuDs+WSR9rxIm0wz0NasUSCBaI9rimhjJWz/cDIC83owD7fv3ZdkUQtPQqFa1Y+O/glqtPduHbW8iMlH8Vx3YipVRVOfYGQ0STKDvmBcYBUSBuA2VI++JBgWuf4z1P0J1XQv7ui0wFa6iU/3Is6i6LRWzR2xazD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPR2lVr4M3SnhHkXXRAKxr9dNKgUtkb3vg5+GFnmTOM=;
 b=bFubBBdSVeuFEnEBMLWVF7OvG/L7t1wkZWqIOQz1R1c1YF27ol4AVh8V64LeZrLFaHd/dJxuwf5is0XqMJMrlgC4+YW9DMthX4V2ZFqoxzHGTPW8zMGk1qj6y1JzTLtP4WohcfnHDL8+WiUjd8djyX8R4ni/qMRrmIX9pOaOHFcKiw6vir5u4awBw6KBRw52SU9gwx8DHeXocth1xJeusofxv4JMNCdjfojWEYGw2Tjb7qwWNlJz8fNAWzo+JFsSyHdoFPnPfxO2i+inSuuDKu/Am3NkhILwPFfwZDgojdKuasnkdtFqaR82LjeW3zJYqWWh8/g+m0R1Qd/RbCQbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPR2lVr4M3SnhHkXXRAKxr9dNKgUtkb3vg5+GFnmTOM=;
 b=CE1fGdbpiaDWD3zv52XbMaeKPos9NlNDNibvi3uu5VFSeqx1jlNhbLF+Wwiu7jKSnq2IiniRjFZOACygSrOSSghagNVDUe57rGGG5flon91WkD34eCPGp6j1BMrxcaEKLZBjyHUQvXdbDzjynZ5nXIlCwKMWAsSK7mBg2LPuONA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB4618.namprd17.prod.outlook.com (2603:10b6:303:103::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 18:51:16 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7e82:eb7d:47cd:2ebc]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7e82:eb7d:47cd:2ebc%4]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 18:51:17 +0000
Date:   Thu, 15 Jun 2023 14:51:13 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [BUG] Root port fails to match with port driver on non-RCH
 topology
Message-ID: <ZItdoWTyOS5YSPzz@memverge.com>
References: <ZIs5Ra+9SGGbUZoZ@memverge.com>
 <ZItcdaq3j8kW+/Sy@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZItcdaq3j8kW+/Sy@memverge.com>
X-ClientProxiedBy: BYAPR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::28) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB4618:EE_
X-MS-Office365-Filtering-Correlation-Id: bb62b6ee-f7da-4f34-dafc-08db6dd18013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nvg11qhL058h2aGBlc0lQ+MAxcZyWmFNLh50avosQuDkru/HMg/iPxYbYtslrZqEzXchQK+2dVYAYU0l+GiAYXk8gZuU9EMmIHdkTJjEumwpKuoskADYwAXdR3flQDchtXgKuwFthdrn7Vtw8MVbgnY7PZ3NQyNSQKjoYTpw0eNzRXGkIGLuFqJk/EsWTcTRKz9HQ3HKNTJzsOYTLDBOpC2WX1XTFaf1p0tV3QluEVJT8S0MOh/E3PyDQ1ggc/3XwFajBcclsA0L3ETOxov2uQcLLnyNhi2nE6Xqc95Emp1PtJV4Gh9CTVXG86AxjRWPV4wHLAbSFkP3Tdnosc/PNSKNuaiFLjuBLm44MUEwAYXyz5UXQpaKcNxKnbqR55VeUKRzt84AlVad7oAOWY6HJMehWQoPfxZEMEfekK+Hy7KpZcKr6JHrxtKfvvkNRv35bQjz/XOtLNQrTQYg06sx8wU2P3Feie/PJLGjA2qtVxJDzOYEJpNR0f33PXSzDlK4ITFYove+s/p/H83bva9MNuOaTkS4pQagYxxG+H4cDE1P2dcJDsEyDzeFIR3v4MVF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39840400004)(396003)(366004)(346002)(376002)(451199021)(2906002)(26005)(6512007)(186003)(83380400001)(2616005)(6916009)(66476007)(66556008)(66946007)(4326008)(41300700001)(8936002)(8676002)(6486002)(316002)(6666004)(54906003)(86362001)(36756003)(38100700002)(478600001)(44832011)(6506007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u4hUo39iuS/ZSN3JtRGHePcQRphm+o/nf3dQU28PVddfDqd4mKExHOaRN3M5?=
 =?us-ascii?Q?isSToyfevJb23pu6uAOH95f1vwktodGhE2PTng/2xaJVOTmBf+f/IlsFY9ZX?=
 =?us-ascii?Q?HhzjgCaVnLXsNZ4etGYDcHmsbBw/de8boT/Mu6FwNDc5O2EQ1Mikm6/ZSbje?=
 =?us-ascii?Q?pzgF9ZqKMAM2iU2zLrChJbgcWMkCfdOkoB9sQXsrhnAvu1sD9MGvCMAYWC2F?=
 =?us-ascii?Q?mRMov1xH6SQDIDZO+SuX+HjxxaOA5c3evdzbva3fwRpMXkBtqSLOrKQu1ysS?=
 =?us-ascii?Q?QqvOb5alyI/yRkpknoPpxO2QK0G8+bnhVEljbB8xOQGZw3Sbe1AI6DaU6mqP?=
 =?us-ascii?Q?acVTIHJw1lrDtllVynmBQL7hG3E56KUsT15ReMevQdmUVKYop4ZSVvtZdqwR?=
 =?us-ascii?Q?S79JpUWkZwCB+B08Q7CGDRVOJfFRH5ZNQCxcBRkjFdZYf/aABQ+fat2wZHSk?=
 =?us-ascii?Q?AlFx4z/TB6waA44inINjNdAmh+VoUN0zJX6aduNG6yvla//VZkzMY8tqY2RE?=
 =?us-ascii?Q?APpJF0ErLGv2ULmKmWTqi+dIw321x5LTqwtNVZw/gS2oKdeZw6P+2GewJR+0?=
 =?us-ascii?Q?lNUNjBPOB+TEvTrWpWjRlOlmVYFylnp3i6MXEs331gkTaT4yuGx7m84lw3wA?=
 =?us-ascii?Q?VD2UJ5kn0vlg21RTcR4h+SH8zO8fLIXgL1gkdYfEzF1X5iKGBCBJKCopRTwo?=
 =?us-ascii?Q?kKqTMwYHGH+FbOnxLu2bBeKFwnfo1fRrXvb0+kpdlBAtLfjHHK/bfLNqs63I?=
 =?us-ascii?Q?+NoxAGKXQ4EOYeS8xZlJTDZs9ZZV+bN5D73VxNEQeIrQz7K+5dDgmxYj6LS9?=
 =?us-ascii?Q?6Zi4HxtQBdjq3dF4C1M4pVQ+ylDLbqsk9Bu47186pq5cLqXMEyJIcpiqWv+h?=
 =?us-ascii?Q?v6qAbyrP71hntS4rcvijFnqF1dr6O/vjxq8DSm5X23obZkhbQeQtGAEEaztF?=
 =?us-ascii?Q?ROSi1V4/jzMFUS3niDDLXWuNmOKZ8oqmJ5zaoJ+3NcgaBYa03DhRy3BWZr22?=
 =?us-ascii?Q?G1oyMOXQlD1H16u2fmdlTR+xCbtNx9baTn2sRAesPpEQ2zA/bBmnDrw18D7A?=
 =?us-ascii?Q?n8D2UC9xXhQfQP72UgiY+AGcx3rbe3Mc7HZng2iUs7zfhI2RUNyOvrqYpKno?=
 =?us-ascii?Q?5rI67V6vO5XXNp7zfVzc/Rwd8uPS4F57sdS69qD+siI4ZkjRMD1VYwHZUEXW?=
 =?us-ascii?Q?PbuGlhz2L6d1j0YDBoeuUJPm+qP7ceVdzTZqQWOvhQYrIzDlAuaRHmWuPMKt?=
 =?us-ascii?Q?xXPK3S9F6OYfV2c1UgSEawqeJALxUKI/D4az2kXVN4mxmnUj/f4AdUbue9Ho?=
 =?us-ascii?Q?xvomynC5XA9YgXbm257l4eN5cFofWR6h3TTAFjXPnryPsOWe4lDOrtrY6qzR?=
 =?us-ascii?Q?cRgPdKNyXI+Txsb9sgtmVPV0Jz4Np29PYJdxLVWbDtC3G1QRbaxBtHxKyv6b?=
 =?us-ascii?Q?cXSGK5L5/KeZx+MARebIgyPVcvn9rK04Bpk/8VHmyg7t3+LkZQUuEekTGQjp?=
 =?us-ascii?Q?5yjheV2OLRTtK4xkuPdin4mg2y7zoK7H//1tuMAzvsTs65l8R5E6o+6m4Qxe?=
 =?us-ascii?Q?7G1hpgukpDShWbQCsBW0DQCn0LJFxsHoDdUFvumwJbtSX9RykwCALrFTrPaT?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb62b6ee-f7da-4f34-dafc-08db6dd18013
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 18:51:16.9555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7tlpnR9H6DYohyvB/HNRZ026q3xvuP6Oap1lmk1Uy9/FpH9muqLFek+7a1Q3rA7V64wmL4nc2e4BqjMdjGxZ7p4PMhqc411cJOeZiC5oAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4618
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jun 15, 2023 at 02:46:13PM -0400, Gregory Price wrote:
> On Thu, Jun 15, 2023 at 12:16:05PM -0400, Gregory Price wrote:
> follow up with more context, there is a subsequent error on
> cxl_port_probe which causes dev->driver to remain NULL.
> 
> 
> [   15.561313] cxl_mem mem0: CXL port topology root0 not enabled
> [   15.561315] cxl_mem mem0: call_driver_probe failed

wrong prints here, this should have read:

[   15.549316] cxl root0: driver set to cxl_port
[   15.549732] cxl_port root0: call_driver_probe failed

I confirmed that call_driver_probe sinks down to a call to
cxl_port_probe and that is failing on cxl_port_probe(root0).

Rest of the commentary below is accurate.

> 
> 
> drivers/cxl/port.c
> static int cxl_port_probe(struct device *dev)
> {
>     struct cxl_port *port = to_cxl_port(dev);
> 
>     if (is_cxl_endpoint(port))
>         return cxl_endpoint_port_probe(port);
>     return cxl_switch_port_probe(port);
> }
> 
> 
> since root is not an endpoint, we probe root as a switch port.
> 
> static int cxl_switch_port_probe(struct cxl_port *port)
> {
>     struct cxl_hdm *cxlhdm;
>     int rc;
> 
>     rc = devm_cxl_port_enumerate_dports(port);
>     if (rc < 0)
>         return rc;
> 
>     if (rc == 1)
>         return devm_cxl_add_passthrough_decoder(port);
> 
>     cxlhdm = devm_cxl_setup_hdm(port, NULL);
>     if (IS_ERR(cxlhdm))
>         return PTR_ERR(cxlhdm);
> 
>     return devm_cxl_enumerate_decoders(cxlhdm, NULL);
> }
> 
> 
> It is likely that dev_cxl_port_enumate_dports is failing, though more
> investigation is needed at this point.
> 
> What I don't know is whether cxl_port_probe is intended to probe the
> root port, or if we should simply be attaching the driver to the root
> port device explicitly rather than going through probe.
> 
> Any guidance would be appreciated.
> 
> ~Gregory
