Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A16ECAAA1
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Oct 2022 14:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbiJ0O3O (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Oct 2022 10:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbiJ0O3M (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Oct 2022 10:29:12 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03657185435
        for <linux-cxl@vger.kernel.org>; Thu, 27 Oct 2022 07:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlxbO6kp2of9kCddrvmzP4sBtAMmjjHoWUwWdb1NpV/8bWYqS+IWdvzOYM2AVx3gwnsCoW231v0GhqzE7H1SxhFEE/qjJzCZf+tnMNH/wuJ+AvP9t9C2VEsiDxI4/fKxzYVTGlgiSp7Etq+Q3ujF1xcCpwf4v7C00WiWkSjfZ8BzNHGMJz9GAZ/XKhrVomuWFEJGu2QqqRmyGN//9Ik8DSnEuHo+3jf+6rZe5Z8cWvOEZz2nBhCn1TYeQjHaZdqPlFT4VZSZbm+5I8oELX1F2r3PAOczL8jxqnDFAI/autpQ3Dkb0Fhmadp7oWZltf3v9lejCAChuyzOWltiiYp5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5mpiiulujdsG2CAYngb2WrARFLSP9++urRBgGNj2DY=;
 b=U53BNJHSTK1CaOoFS+evUX/2W5Q7ogx2tChV1lpPlXN50T8+TOTgpalJQglz8e+cKP03edWKYzC4InyrtsRw7HMBLj/2ZjToHGfczD0/aCF/EUFb3tlSTqhpJ3HPXbvY0BqYcx5MW8drpTQ2BVI819jlP5oxs5f+5QfSgY6czsLa57lvx05MiqATV5HozgIZQJLKa1rXt8KOeR3qiv09Qe8W8Vg/XafAsuPesI0LNgHkHjEM/S1xEBchhoYELVXSvUdC5S/zt02j3WquO+vG8FD4ZBso6Dx8d7aQjFkwlCvmfOEAQIRdHd8z/n0cp/HnH5O3CNzn0dxjj/UjVTCBXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5mpiiulujdsG2CAYngb2WrARFLSP9++urRBgGNj2DY=;
 b=WUY/GFYajK/J1Mcyr747JqPbK10bt9Jbmbgcqh/siOCI9idiwVQ+iyQlpAbOuhCuG9a830wtethJ4zFLatsgxsOPeft6UWUBXSBm/Hrn+6d31Qa2Dity55xW1FDAEqktnQRExenS/Lc6BKkwQLseSLWiVFilXox/qiWxuzmcok8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by SA0PR17MB4128.namprd17.prod.outlook.com (2603:10b6:806:83::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Thu, 27 Oct
 2022 14:29:08 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::138a:e3a2:9ec4:a18]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::138a:e3a2:9ec4:a18%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 14:29:08 +0000
Date:   Thu, 27 Oct 2022 10:29:01 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Adam Manzanares <a.manzanares@samsung.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
        "imammedo@redhat.com" <imammedo@redhat.com>,
        "ani@anisinha.ca" <ani@anisinha.ca>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/4 v3] Multi-Region and Volatile Memory support for CXL
 Type-3 Devices
Message-ID: <Y1qVrW8NQkbOpTOQ@memverge.com>
References: <CGME20221026004835uscas1p1d37255ba8daaba8fc7e16e5129cb94b5@uscas1p1.samsung.com>
 <20221026004737.3646-1-gregory.price@memverge.com>
 <20221026201318.GA308524@bgt-140510-bm01>
 <Y1mc1mvxsGS+7JBp@memverge.com>
 <20221027115854.00001f76@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027115854.00001f76@huawei.com>
X-ClientProxiedBy: MN2PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:208:a8::21) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|SA0PR17MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: 1906dca1-eee2-4049-cc6a-08dab8279b62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eDpGXd7PsCbEYds3R/DXElLblyntCbwRaeeCdHTgA7AmziX/iDUS1tfWtTIh9OMEuRrUZrGN8qOUrSoANhfVAXAJExPXWTZeVpO+Liu8r9YA6wHczXA11Z+88pijKzIFrc2JzWMpLKrs5ad201MKno4arxk8WBZNgROkT80oEsmab1TjiK4hNmFsU64WvTY4D3lbTw0uvRGr5COVi2spsB4qhQIQjOUnIzoO+sMaqi9KksIZhIW98Pnmlbr/YoK89xBn3dHPBhLfyBFXTC1VPqGvBfGmPX0Hcawmw7g9yrVgRL7jGFDJeXPa3ovNJXkzOFRj32MI+R3vlDUXMFZEYMu3uVVz5bnsN9R+LVsVZAowWZCO5TMvAqJFQ1u0dELhshSO3V5mfvl93o7J/oNVKQs7A9i5GL3Tlg1sOOxCLZLk/asFEPnL268njicPueZqF72Uf0+0QGHENh8S3j0w+LOrh8LrngYQ0CkUqzOf/0EjA9X4GwXWdVtarpfYSVfXG/e1NGhqlOR6qLR9pHXbTgweYZxLVsre7GgsPzRqSSO4Gz14zVIwYYxfa4LgpbppeTQW2sVWzHSgot+j0BvD1U8abH6PeDgF4ekxMavZLIklFmQruli9OYI9NvYFTDAkW0h+5q383T/7K8ekS/WQE2dL0hCzXbKNp8CXIb5SJuT7MvpPJD3rFgHE+/YL8qgNNTnVaYvS0HaJLPvVJgoTGcywWs/WbwJWhnl7CJm/5Mc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(366004)(39840400004)(376002)(451199015)(2616005)(6666004)(186003)(26005)(6506007)(6512007)(44832011)(83380400001)(2906002)(7416002)(8936002)(4326008)(6916009)(66556008)(54906003)(478600001)(6486002)(966005)(8676002)(41300700001)(5660300002)(66946007)(66476007)(316002)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SmGqZaBIOkyQXW4HfGNt9DEsmfybK/Mg5MZtF9fjQ1H/r4k839R7Hh7Bophw?=
 =?us-ascii?Q?oICuuyphPD0ikmDYamaQ0hjPjIIMGTfsrdLo43XVHOpv/gNNbqzLFoQvPyEd?=
 =?us-ascii?Q?r8SQIiyq0+PssxhZ+pAp2O+BIp3La1WFsOkTZVZ9oYH9tdQIoU1a4UGpk+K9?=
 =?us-ascii?Q?hByMo+aL6DJchq0wcQz5vO6h05u0KJWpyiyjud40oX2DJ8QEoY6byNmlO/p9?=
 =?us-ascii?Q?r3gbkFYRrtYl/tJ8bENEsYIHDhOTD8JMY/suFMa0pDr62vrVwdVyzVuNRTub?=
 =?us-ascii?Q?1lRyrC2v1hIcmJrS1ZjRG5Y0lKQxNk5ObjQHBP2d/Me1WVMe/OeRHKmpxR9h?=
 =?us-ascii?Q?KPWKGwek98tjroH7wrh9JAHda8Z1vq+dqOxozPcY/FCS6wVhpWnEiW9Fb5tn?=
 =?us-ascii?Q?eAyt0A5ffaeFcjAFlzkKUu6mH45peyl41U++VpdarVxTeW2kY5HUtlgdtEOz?=
 =?us-ascii?Q?o9sBPvkAWF7wIqGRw+UwFHOmQQufdUytjwrsPM/ij6R9CSMvXUEU+lnq/zHc?=
 =?us-ascii?Q?e8lYXd1NZjjZL+vnhy25QzcNxxj5F+YIKhu8w5mjfm/CwSDRffePVINN6JdL?=
 =?us-ascii?Q?PQu7Te9izW9Zbgd1JJ9gDWiHUMQNPXoKQKPn2tAu8EWNNO1ZN2xUtZGpt00E?=
 =?us-ascii?Q?UMhvcoON1X/R8CUqXOzxPxJXGwwXflpaNznuIXNUHwKM3taH3oEG64dWz3B1?=
 =?us-ascii?Q?kY2964veBlb4VgiJTgKKGsyj9zVovGPiKfe+/Ee+WJ5aKXiQkbe6J+b7gEcs?=
 =?us-ascii?Q?pgtjjzrqQZflYQLO/6Jwt6iGH12jryvjVox1gAk5jI2C6ahA6N5yrQT5QknY?=
 =?us-ascii?Q?jxqMu0yLCTFG+eohG/QSrZNffK4U+kwBfZY75IypliXeyyZkTLJoyRRIaiKF?=
 =?us-ascii?Q?Q51xqt1X7iilgtcdwzJyNl/dRo64BCfWMr+Fo6jXUyFSTZXfE4ZDarOUpY3D?=
 =?us-ascii?Q?/a7AcvGiaRmprLmsk/1jisjathq7PVFnSbTyJQh5ZT9/EY4GP4/GYcJZSVfI?=
 =?us-ascii?Q?tMLzZJm0v4o5MzTAzowv/14ne0F2tXfjbP1Do+twSrm/q63WwXOA+2QcwDPI?=
 =?us-ascii?Q?S+m9KnUysLQwuauYbIe81gobbbck6YdUka6I7WCkgZeIu01ko4QyVFTOyG39?=
 =?us-ascii?Q?pbby18uROMac+5AL4fY+URDfBE2ErXWGTre7JgQqjj1C09ejQhCGS8moM6AQ?=
 =?us-ascii?Q?f+hsoKi7M5t+DC8TmCqXlYjovw1GKKGj1Sq7C9IQYHpj9vJIw1d/sgGLEPOv?=
 =?us-ascii?Q?4sepUq/cOR104y2D9jLoyZkB7pZWOK/8ELfa3UTbPER1rgCBjFt9J2+qPGFR?=
 =?us-ascii?Q?yNRAaNfu0FL+63qfdj4+gGAtd5cgjwzPkOb6yKpbmok6TLkJeKw9bEG9WbWm?=
 =?us-ascii?Q?uvYxWATir5288PtJEc5WFPYlXNaZKkrWERbp4XpeQheyOsGkobisu8oUMOfY?=
 =?us-ascii?Q?G1k3ACxR+O/V5NaE1eTQp83MZCAkyrMD/haGkiccMdBegZWF+IHEnw7LoKeQ?=
 =?us-ascii?Q?0FUcbBO8mZ5wE+Gvq6ojCo+vLawUBu54PCrHMlLbHr2WXzA2K1mSbzoJHf4R?=
 =?us-ascii?Q?Tz04LE8fjcJ9/8aFOouClpKFL7IO2w1bt4ROSjT45D8/K0OFCmgZgzAmBA5g?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1906dca1-eee2-4049-cc6a-08dab8279b62
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 14:29:07.7462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HK/bPNiGSptZq4Ph4MLxxygrGKAnOZEcGS1mPwFH5ilAca+7dHM3rwDJXWmjHwLmVugg0iR5tPE+ezOjW3I/WJFF6JB9i+MaCQ+ZdVrVX2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR17MB4128
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

ok to summarize then:

patch 1) e820 - submitted as a separate patch/bugfix for mst to pick up

patch 2&3) Pickup by Jonathan for his branch as it depends on DOE and other changes.

patch 4) incorrect, this should be done in bios/efi, drop entirely

On Thu, Oct 27, 2022 at 11:58:54AM +0100, Jonathan Cameron wrote:
> On Wed, 26 Oct 2022 16:47:18 -0400
> Gregory Price <gregory.price@memverge.com> wrote:
> 
> > On Wed, Oct 26, 2022 at 08:13:24PM +0000, Adam Manzanares wrote:
> > > On Tue, Oct 25, 2022 at 08:47:33PM -0400, Gregory Price wrote:  
> > > > Submitted as an extention to the multi-feature branch maintained
> > > > by Jonathan Cameron at:
> > > > https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cxl-2022-10-24__;!!EwVzqGoTKBqv-0DWAJBm!RyiGL5B1XmQnVFwgxikKJeosPMKtoO1cTr61gIq8fwqfju8l4cbGZGwAEkKXIJB-Dbkfi_LNN2rGCbzMISz65cTxpAxI9pQ$   
> > > > 
> > > > 
> > > > Summary of Changes:
> > > > 1) E820 CFMW Bug fix.  
> > > > 2) Add CXL_CAPACITY_MULTIPLIER definition to replace magic numbers
> > > > 3) Multi-Region and Volatile Memory support for CXL Type-3 Devices
> > > > 4) CXL Type-3 SRAT Generation when NUMA node is attached to memdev
> 
> +CC Dan for a question on status of Generic Ports ACPI code first ECN.
> Given that was done on the mailing list I can find any public tracking
> of whether it was accepted or not - hence whether we can get on with
> implementation.  There hasn't been a release ACPI spec since before
> that was proposed so we need that confirmation of the code first proposal
> being accepted to get things moving.
> 

/* snip for brevity */
