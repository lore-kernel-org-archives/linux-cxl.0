Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCCDC04FDF
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 18:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjHDSIf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 14:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjHDSId (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 14:08:33 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA56B4ED3
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 11:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bd+IXgEWF0BY6AiKDuOB55L0dl6mPtubokO+JQDTqldTvQZmTmuLxbUYI55PkTQUuJX13+grR9Hpa9w1DPJBJhb12WQuAVw8GzxT+UUAewYXsnBIh4y1ZirVbmvSwHBMlgQHkLUdiXJ/5DA3ZStPMTxZiTO1ya59dHCxe9g9OAgRosAIm1b1f2ZDmZRrTPkOpODDe5tl/IE/xZ3Kd+XCybQjw/dnUUnGNC4y6Er83Ydcua1qEegNKq9ZWr2rOvoC9HQX2jNcHFv7rhcV002JWW6G88/VRkHZBOLFO9X0956V8ErXlejX284T8cE8V3TOujlYH4bnc1hIMahNq5GKKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=424i07vjtmK/mEVisWXFR0HRWSgY1E4IRFnFAmqONeA=;
 b=KGeBE/ssg4aH9IFQbJttyIAaPhQNt6RBqGSPXzy0/QAGVvQD4QKsuT3bJHZxApHIgAoQ3GWZa6hsWcoZ3r/5iNipL9MWo0AWlag1ilUE1sQnEBTJTo4fCp9xF2fa43EcZ/HwRdZRNpU71hbsVBFMmv+wdQuo6nAyO11DrBiDD/tmP1gSEQ246g/hMjFh0TUPUE25fTQXV1YkpaylCYcd5maW1OqjQwCVaxlO0My6NVXTsrgWq6ADhpXuE0lQMqxGZxFVr/oFPmIPZqZ29eeD10r51i3hNZlRIxPgJxPyRF26iKNVIGoGN+U0TDW7xhZcnzoqELuTBuk9/Vi0/7aYrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=424i07vjtmK/mEVisWXFR0HRWSgY1E4IRFnFAmqONeA=;
 b=gS+RtwUDux+yDqdsUZGO1gQGYLoy8q74/65Vkg0FaK0yAfvX+vxxqrWEat0DhkRarhU4jJYH+/833yHZPS22bn5LkSeO8ngc4LFXHAPfRjHGC/7X4mKf7R5lhAbZc+PaF16QjhUb56jk3DB0BEaQplTyzxMQN2Wy93v8vjRpjJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB5755.namprd17.prod.outlook.com (2603:10b6:510:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 18:08:04 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::28b3:ad85:6a11:3872]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::28b3:ad85:6a11:3872%6]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 18:08:04 +0000
Date:   Fri, 4 Aug 2023 14:07:55 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Fan Ni <fan.ni@samsung.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>
Subject: Re: [Qemu PATCH v2 5/9] hw/mem/cxl_type3: Add host backend and
 address space handling for DC regions
Message-ID: <ZM0+ewZtknlOrGMl@memverge.com>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
 <CGME20230725183957uscas1p1eeb8e8eccc6c00b460d183027642374b@uscas1p1.samsung.com>
 <20230725183939.2741025-6-fan.ni@samsung.com>
 <20230804173623.00007707@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804173623.00007707@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::21) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a772df8-18c2-45b0-412c-08db9515bef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUZZCcp89U7QlxJ8dcmy3+atc/OlFtxdW445N0zcVX/yxcd5bdBO+UWPFMdT2yJVsEPW6ha9mHVPA3Qka+sTceRJU5axnk2CIE8yA6OJCyqvvjmiD1zVDDsVIcn/9mOKVT1g/mH469E7icHZlFdCC3E9mZ2qngbF9Yiv+up8Wr3+xRJOOua6osl57FV7awlLbXv8fAB0Ej9DlO6rUXlLc4OMOUHGuot3l4v0EZ9xtYh3BzyJmwBe4Z/f2BrIID08+43jt4VgpA0Ja9+AkC4qI3uI7flq5AoAckUqS0lnfyaBQhUkqruFoAIXBCSifMAxtiwyVRlM5fj9vbRP0FtHsTNVloVx7TsaqImDiMYf8gSCIU+QNrUcfPb0TT0ekq1aLDN8haNtaiPFdxpq59sdhBcIw7K4gzdOuZWZqJfgc1xtLGv2CpEupT4DuINsTe22CIe4ZrxRHBVxT3q9HEI/QfcHNXhErhybx6gaDf3ecJy5HyncQf+wXGvme5GOEdg4xr1P3LDyfaLfhq42ck8vy+nYk01JGK7BZ9zViYLQvyj9LtI8vYc6LQH20WFHwINr2hA+OF19YYSWPlsr8AFTBtx+z16aXykxCrS/KOxnfq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(396003)(136003)(39830400003)(451199021)(1800799003)(186006)(45080400002)(478600001)(86362001)(36756003)(6486002)(6512007)(6666004)(316002)(8936002)(8676002)(41300700001)(5660300002)(6916009)(4326008)(66556008)(44832011)(66476007)(83380400001)(7416002)(54906003)(2906002)(38100700002)(66946007)(6506007)(26005)(2616005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DVLeacuQr2AomBcB6uwjb2lMbXk/2mYSObaMsdnOGZo5nI+FCt5Mx7P6RBqY?=
 =?us-ascii?Q?VKKrjMQugu0un2lAGwva2zeAnRuQBsUKEJzH6n7JweVUOGvVmUVnG1zBMK/V?=
 =?us-ascii?Q?nwxlgOOOtFIWXv+nFiYPY0HxSIjziEIvN1+uRPE8oIatWBhtyrTyM1eJPLMn?=
 =?us-ascii?Q?ndb/WlhmWhpcjtp3hKxJO+Fs7gQDMW1AqLZ8AjuqKefwYuDbL6aSG12kePBc?=
 =?us-ascii?Q?kOBWZNAyRnI8h61NA2D4eMVbo3M97hynTzuEdRJbHHbkEcFoPixXxoGk38hd?=
 =?us-ascii?Q?pnF/BrdRDn/HxZWieKRN5cJLXxgsVp1Y9WyFXPHBVR2YNnZfLH5NhjHLAziA?=
 =?us-ascii?Q?o07n9JMSuXVPqrMfpO5NJ+rjqwezoLkGScrg6BwgZs/OQjv1MmKc9ZZmGLUq?=
 =?us-ascii?Q?Riwo6MppmygdjyaUUtOigW2ulHT0g6ChUnIxK09GoBB/QwuQP+ogosoMHhDS?=
 =?us-ascii?Q?DDyeCBMrP9TzjCRN5rNdZQvISzTvktN2PA3a6QbtRkQv4XwluKoYDz0HgXav?=
 =?us-ascii?Q?Ndw6PzpZm2pc6eqzkqML4oNYDKchNpU89xvbxCUY+YXicFECw2pfVwdkxcED?=
 =?us-ascii?Q?xfApXLA52/lJmjNFKmj6OnLjbeBwYrILB3tJ9HZ+CHy/fkiYs89BkVPKXJM8?=
 =?us-ascii?Q?Llg/Ngy6d+XgD+38sc0saOzKBOzZyN66eFCN48ztwXCG0bz9LdCeQlqDuBbl?=
 =?us-ascii?Q?5cOKp693zmxe10bgTK8Cu3V2uR3xRjuTIr1xv9OKmKVHDwvQizzz90YNIWhh?=
 =?us-ascii?Q?EEfHzPBzwhnywMjM61+Lyo/ZQ1dp/EFskbPYWXdv4vxZlVzChUaQipFGk5Eb?=
 =?us-ascii?Q?uwnLS9z+aWh2viz+gR255cW/hiVSkYiYsGRNThzmsSNLEtSOLOxLnVKrUYYT?=
 =?us-ascii?Q?Ujr/BL3W4xuPZY36BkiTwtymwGM04HSx4kdT+ob2OtTXdguBvLMEyR5ghhx/?=
 =?us-ascii?Q?HIR7Owz3/Z7vhP7xF3BeFFwJIc51dR2i5OXHQNQMLSR7j1/Y8VghDboIylLW?=
 =?us-ascii?Q?DLRLSVuOdX17NX69A0+IfjwWijo8KTyA6B7okrnIvboag/TYTlbxqfHaGe2L?=
 =?us-ascii?Q?/XRhbJ0attgj44882uDCbY+5u2wbWjx5VmI+DX8nFyQvMd2bHLXA2iIf8R5R?=
 =?us-ascii?Q?GOG2Tya0giNM5eJQHBIIarn8cgzHw1hJZiAigvt280PW8OmALUf1XLMl2dvV?=
 =?us-ascii?Q?dvhhJ6/E90aclbmXPndktuppTrnIMOvOFnt98kCRM88y/QqwKdkRJ8MieWbI?=
 =?us-ascii?Q?tojoFSPBzPHv9KsqZz4TLHT1BBQfJZYyI3TKfpxMQmTupvwm0FH26Wu72iY0?=
 =?us-ascii?Q?lZcMt6RRw9fhtAI/tCQYCnkFm4wPc4Q9WnYWi7txopmbqGYHJITiE9s6rkim?=
 =?us-ascii?Q?W/CPsNeIU5/s9gn12PKmxD8YglDVrg6GJ7LL9e7FmR9dh9h7tJQTtJpgaWKb?=
 =?us-ascii?Q?BVlFRp2ysyd+0HU+Ua4ns8KbYwslm9lIObc7BF6QUPTm5qgbZHUfs9a7fcNX?=
 =?us-ascii?Q?GJZM0VzQpPYZj0lylVZRiNyQE1BCbGEcirpdYY6kvYC5kyF8GKsI0C1zHYEj?=
 =?us-ascii?Q?qu+x8c1H76uJFMukpdS/JOw9E4ZK1SL3mZm2DrzvLjr7TT6lZXdg+WimDLYi?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a772df8-18c2-45b0-412c-08db9515bef9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 18:08:03.6390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cj2nxqda2eNaQi7Zgy7Ctl2QERnayKIgYJIclLssK7RijvOF+bwCOYAlVBk8IQz7LBAI31Rd+9Qe5hKayKQSoYi+vdTuPdJKv31RAETqgVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5755
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Aug 04, 2023 at 05:36:23PM +0100, Jonathan Cameron wrote:
> On Tue, 25 Jul 2023 18:39:56 +0000
> Fan Ni <fan.ni@samsung.com> wrote:
> 
> > From: Fan Ni <nifan@outlook.com>
> > 
> > Add (file/memory backed) host backend, all the dynamic capacity regions
> > will share a single, large enough host backend. Set up address space for
> > DC regions to support read/write operations to dynamic capacity for DCD.
> > 
> > With the change, following supports are added:
> > 1. add a new property to type3 device "nonvolatile-dc-memdev" to point to host
> >    memory backend for dynamic capacity;
> > 2. add namespace for dynamic capacity for read/write support;
> > 3. create cdat entries for each dynamic capacity region;
> > 4. fix dvsec range registers to include DC regions.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> Hi Fan,
> 
> I'm not sure if we want to do all regions backed by one memory backend
> or one backend each.  It will become complex when some are shared
> (e.g. what Gregory is working on).

I thought about this briefly when i implemented the original volatile
support due to the potential for partitioning. We landed on, iirc, 
2 backends (1 for volatile, 1 for non-volatile).

The reality, though, is the driver (presently) does not have a good way
to create more than 1 dax per memdev, and in practice with real devices
we see that this just tends to be the case: 1 dax per device.  So unless
that's going to change, ever having more than 1 backend will just be
unused complexity.

To me, this is a good example of "maybe piling everything into the core
ct3d is going to get ugly fast".  Maybe it would be better to do
something similar to the CCI interface and allow for overriding the
other functions as well.

just a thought.  I apologize for not engaging with the DCD patch set,
conferences have been keeping me busier than expected.  I plan on
putting it through the grinder this month.

> 
> A few questions inline.  In particular there are subtle changes to
> existing handling that are either bug fixes (in which case they need
> to be sent first) or bugs / have no effect and shouldn't be in here.
> 
> 
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  |  19 +++-
> >  hw/mem/cxl_type3.c          | 203 +++++++++++++++++++++++++++++-------
> >  include/hw/cxl/cxl_device.h |   4 +
> >  3 files changed, 185 insertions(+), 41 deletions(-)
> > 
