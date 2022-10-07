Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B252C433F5
	for <linux-cxl@archiver.kernel.org>; Fri,  7 Oct 2022 18:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJGSqL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Oct 2022 14:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJGSqK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 7 Oct 2022 14:46:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92A23B96C
        for <linux-cxl@vger.kernel.org>; Fri,  7 Oct 2022 11:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpLki+wg8sFsWe3MExl56Z0r97B4sY5OruEW4G5qsMt7LcmISuNvzBvNYTA2vULv8t5N60bvAaRb+nMukwcOELMM5D4/BbfXvaEFRmraX8TDb6OatOqIc33w6Q+Ky6LGz8aArAifVvTzEskQyBrDTHnY1puvd315HAJFdKyqiUlcky4G78GHBGWv2ZzRgq6sEEbciPuxSFx/IlxVRaNj/nGbH1E8ISRUYH8rtxmK5Xnyn2ZEMtmK0eUlTXAeAW5p86SBIfj36/uMmyGkBH4rmeeNrfOW7+NgbCunGlCVgFsk/zjB3KCoMU42Ybi2p7jUw81/eKLBCN7mZPxXnM5E8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEkBs2O6+KzMSkUu6Cw11zQO2SJV7ZnmQHWEtodGOlY=;
 b=Az5oHbIzOJS9+dP0cRwqGYR3oibj2YH+yXnKfDGm95P6JmcoyEV01P6frbCzJHnDeEivQqDvbEiehDAbgGcYEBqTq91DNjXcNwJCxHMtBIzf7oXaFQCsJRHPeaOW0SCoXTVoIWmFBvJLc+WGH1rY00I0u3yYeYb4WKXRGEHk1irRt4TOvxUnNV21PsNCYAYPuwpCxwHpWok4TqWIgOJaA+wWKCQG6suzR/Mv6SoZ95yESa1KNot7BUNtFedIkBoNp30gtr6/TnOkk34FuD6OTO7+6c3gP2JC0V35DbAZxUF4GacGMqfqYw5YQ7zKTUfM6xo/1rgyscHL5JUwoGEfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEkBs2O6+KzMSkUu6Cw11zQO2SJV7ZnmQHWEtodGOlY=;
 b=kq6R3+PohVsL5WH5CJV37lLqo6TxcaY3ozfR3pcJkNyCyx2epXSAaDRBGX/LktEd5dPyJXn0zN013D3ATq6qt0TuxNDggADZoFGzR2xEFtSbeVvAZJmlKtNABVSFwV/yUBxfn/n8xbH8zIAvfX4A4MiEwR3Ofqcy0VlyVUUaTCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by IA1PR17MB6288.namprd17.prod.outlook.com (2603:10b6:208:428::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Fri, 7 Oct
 2022 18:46:07 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::655f:bfa9:e33a:5af4]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::655f:bfa9:e33a:5af4%5]) with mapi id 15.20.5676.036; Fri, 7 Oct 2022
 18:46:07 +0000
Date:   Fri, 7 Oct 2022 14:46:04 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: Re: [PATCH RFC] hw/cxl: type 3 devices can now present volatile or
 persistent memory
Message-ID: <Y0Bz7OrSxBYNGfNR@memverge.com>
References: <20221006000103.49542-1-gregory.price@memverge.com>
 <20221006094557.000035ab@huawei.com>
 <20221006095007.00001271@huawei.com>
 <Yz75ppPOwYCvNamy@fedora>
 <20221006174214.000059c7@huawei.com>
 <20221007181619.gumcab46ftnvhwbi@offworld>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007181619.gumcab46ftnvhwbi@offworld>
X-ClientProxiedBy: BL1PR13CA0386.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::31) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|IA1PR17MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: f7fa1165-6dac-48ca-f49c-08daa89431ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1QZIzvOOStNCBbY8HWQdyDKSGn88ecUtHfg8T66VZXWw6T1qJfoKeAi3qYIdZb5BgMOKITyU2yyn96ZSWnxKD7tVhJ+H1ibxwDP7rkJbAei0Rhe0Xf25pjJQzZYYfhOShE7tw3+RorCqNAfgKnUwXLOsxMlq3Ow7jSuLWfH/ZjGv0jhEpyo3v0uXmE15D1k3aw8hk0X6R5R8SafVUV10ncy7pELvuWiGeID/Rq/t/UmSaNhHZ/PL7RFFt1njfyJ5JfPtfolZ7xGZ5qCa+5jcM1simL2GhCw/8yCJpC5W7wwnwpwbTn5boeiqxTRlPnJGXoy6PBqZUYveiJLp7/AlLgWP1dgByTk27SKGwSuaw8dUCD/VC7fx5O0qq1DfpmIax2quKr2Se4ajH1CxzL3tHuEeLDu+Kw+xLTxSrurK7jQGXzsWK3YMN2EOVGzHQ+7FZMJfU49PgBBjq40Fmkd8idi2ZMAOjJFvSC2h6j1YzDAIWLDEXGcxIkfRQJHyTtQ65/AKB3Z3cyQJFQw84QZ8yOHRrkDEbCZqz/QNBt6ARlTe4zX65nZjNtFkeTdPP0nihSQagGhu72xPekLDHPi3oyf+XpjJBLRqoo5xn4Ax7FhVpTj3kgqGtI8NiIM6phXJ9vZpktnHIP3PPRVsuAWGS5zIZ/inW8yXCQecdMd/xYusMKml7WvxfIP/uvQaTk/OgMD3NHUU1cohZ3HEdEZwKG1dH+UO5MOlSXZOwKnxdnWP0OH12mks7/YKEpKzkwPZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(136003)(39840400004)(346002)(451199015)(316002)(54906003)(6916009)(186003)(6666004)(6506007)(44832011)(36756003)(6512007)(38100700002)(66946007)(38350700002)(26005)(66476007)(86362001)(4326008)(2616005)(8676002)(6486002)(66556008)(478600001)(5660300002)(52116002)(41300700001)(8936002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jTr3RGxBiptHvRj7BA0tg7+uaVKDjLOP3OU3tKtmXtb/X+e1JoL1IHVKZLFE?=
 =?us-ascii?Q?o9sRfvm6Cq54abZJNRkgpHLTsnBMeU0D6adRHvLFLx3tKH4iSZDqf+iT5mwe?=
 =?us-ascii?Q?WziJGXY/3YC99hj8WfKJj1Os38id5WsKpPxIopxoO9+83brqRB6j5DaG7M54?=
 =?us-ascii?Q?SxZV11CWwch5/ptJOnLtQurTrV0qvuj0cmi6AAaSmlCmLMuQZK/vZyxo1izt?=
 =?us-ascii?Q?FViMOkpawC7vjX8F39tvhUM1axzPwiztq2AufVIsUVhtJDDqtk8mjSbvdNZ5?=
 =?us-ascii?Q?ZcfUEbsWBgy4EgnEdZjPpLuSCYIMnMuSBtKsniEU0pMJeu4rGTXwKrFtj4CD?=
 =?us-ascii?Q?tXLiAIjggrV92KweI4sThbNxc0YKUkgnkloIorxb09OsmRrCtHJX5gL0RJQ7?=
 =?us-ascii?Q?QIKlmelAAlsrR0pY1/n28qCzNTenG1QGyZPwhw2oo4A6oGfD5N/7UPfJA2H+?=
 =?us-ascii?Q?ArJhrHFk7HTq62VfZhf0UNPNUlfcj3JaaenFUhFIJ4mfjBXvwI/PJ8kD8+wc?=
 =?us-ascii?Q?1AyMxoLY5bWqByy4QUCINiVCRCqnLLq3ce6a4x5lEjNAlK/MN6mtPJ6yLIb7?=
 =?us-ascii?Q?BhKLFM4FLAPwKzuR0mgS4HMAVk+p3ws8+rvROUJ1g2bBYo9Re2Vr2flGQlhq?=
 =?us-ascii?Q?QJtEyEbw3upFL5+j0DQCeU97J0lT1QRMdE9TLcCzcKa2Wj1dxQ4qbQ0TjXkS?=
 =?us-ascii?Q?nnxfJIwBCgD8c/Dcevby2V6PLuOMPTfaBDrVFQvtN9oZ/lKvxCq7JiQU0+Qv?=
 =?us-ascii?Q?xVVK9woF2wGRlVWPN9sRPM8y71pb2WAbZJHTJCV/rF8rJSJNgDwAdjy71L/E?=
 =?us-ascii?Q?smz4Mz2QkJ774lsYvVI/JXQPt+WzvyS72JOd5Zd5TNf1GQXFJ8huvxPomV8v?=
 =?us-ascii?Q?inqT3QJSGpIhxcXQqTCoxsdSQu1M5Q6bPicjuoMd77p6gTeJpDmycHVc7mF+?=
 =?us-ascii?Q?Falde5YTmyLZuL/66LM3GRa4BHCuTBzX188wDlp7SV71EFG5N8ZFyQ7H/Djy?=
 =?us-ascii?Q?oFZwtYpOJjQLbVvR7J5sdkq+H31swrA2Q8MnFKiJH0zzotGZPgL9emEadC/U?=
 =?us-ascii?Q?cdZqsCpC6BVJPPplGxBxw7gjuqhr6mcUBhHhGv1lTslZ5V2Pi561xh52mZHw?=
 =?us-ascii?Q?4ZHcu4TBKJi/d2VUYR9vrulG34e0K+nx/A6ztAuufE96BxyxkdJtf7xnLtZE?=
 =?us-ascii?Q?q4+1bam0gtidtYmopDqh21u5F6/NFDmJEC0SkXW1w5QHgt7qAX41tB6FX+Yy?=
 =?us-ascii?Q?9rw7Qbpllo6Z8Vj3dBv1Fhm3XT0e8T28/TOxIjpF5cxG6mZIB4QSHnxUEzDa?=
 =?us-ascii?Q?fKoxRAqLJx7wrIDCRT+S8FPeoUx1gv4T1pHtWad2+N1wlbd0EpLz9b6JPaQs?=
 =?us-ascii?Q?wjCTzp1rKL74WfJy664FDIY33Y6lT515WvHxKPpuP4YJsgkR/ikajbU5RyGV?=
 =?us-ascii?Q?cz0L5w//bH5roqLx3gFA0dLICremweX++k3tdD4APoJXvaZWMINi7SFPY5Xs?=
 =?us-ascii?Q?7Zmoda+K0oqmbZQG0f1W6guIAiV7JGaHcvDjWdQ9sklserggaCzZ/7DtRFVj?=
 =?us-ascii?Q?wj/sfeXpGGqQrQvn39zIMnWRcugsXifnar9EBJqF/ta7DHkss5YkNEi5IaI7?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fa1165-6dac-48ca-f49c-08daa89431ae
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 18:46:07.0240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYmiDmOF0cT0HZXl7hZAYXzp4DlKvqsiHjtOI7c8nhpxJHAo09IZkuNkijZEmLVlTEum8c8Sw+G6rJvcJvYJdLexAXy9nfUwOlZeRH0+rWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6288
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Oct 07, 2022 at 11:16:19AM -0700, Davidlohr Bueso wrote:
> 
> Yeah, putting this back together was on my todo list, but happy to see
> patches are out. Recollecting my thoughts on this, my original approach
> was also to support only volatile or persistent capacities, but through
> two backends, and thus two address spaces. Afaik the last idea that was
> discussed on IRC in this regard was to do it with a single backend along
> with a pmem_offset=N boundary (0 or 100% for example for one type or the
> other) tunnable.
> 

This makes sense.  References another message I sent, are the region
areas in the dvsecs an artifact from cxl1.x? They suggest only two
regions are supported.  Was this overridden by the introduction of CDAT
fields that describe the memory layout?

(sorry, just trying to put together the puzzle pieces here, jumping in a
bit late to the party).

> > > > > >  Example command lines
> > > > > >  ---------------------
> > > > > > -A very simple setup with just one directly attached CXL Type 3 device::
> > > > > > +A very simple setup with just one directly attached CXL Type 3 Persistent Memory device::
> > > > > >
> > > > > >    qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
> > > > > >    ...
> > > > > > @@ -308,7 +308,18 @@ A very simple setup with just one directly attached CXL Type 3 device::
> > > > > >    -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M \
> > > > > >    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> > > > > >    -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> > > > > > -  -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> > > > > > +  -device cxl-type3,bus=root_port13,pmem=true,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> 
> So regardless of the interface we end up with, volatile and lsa parameters
> should be mutually exclusive.
> 

Spec says that volatile devices `may` implement an lsa.

Get LSA (Opcode 4102h)
The Label Storage Area (LSA) shall be supported by a memory device
that provides persistent memory capacity and may be supported by a
device that provides only volatile memory capacity. The format of
the LSA is specified in Section 9.13.2. The size of the Label Storage
Area is retrieved from the Identify Memory Device command.
