Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BFAC05027
	for <linux-cxl@archiver.kernel.org>; Fri, 20 Jan 2023 21:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjATVyQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 20 Jan 2023 16:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjATVyP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 20 Jan 2023 16:54:15 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58192112
        for <linux-cxl@vger.kernel.org>; Fri, 20 Jan 2023 13:54:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0U0YvidJQOVqlPU98dBOuLu4NVjM/66MvS2LwdE6Wx0MLzV6w3FZf4qAivLTWV9rD3eyYsJW7rnFjkO4tT7fMi/7kTrm0lSmkVJZMOAx5w4zR4k+9PBdaD6xTAfB1di9DNo91z6fIJVt4SEMIZRoSQ9XEMUDz4Tyv+2284rNJiyqaguCJ+r58MfeKzcnBh9i9bo5jkHeZzcBOw8XLm1TWVDqfgDMYzUqSYmuTtxnguhW1qpGOqY99qW4V3+J6c2pjjBJobQaXF/uJfLwqzxLi3roPzJBZYjl6OWzpZby2+1iu3xUYeHHAytnUfLp2kAE3Cvx7GFp/2MwxFpiHBThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMKmLS/ZWFyZdQ/ap9Ho4dIUOBU1ezT8xny0ZB0Xd4c=;
 b=ahHGThAokZ5HvJ9GawbTF2RLiyuAjchDeOWS069W9zurCd5OruYEB+EWDggY26AIPTa+11L4zyJApZsc6HXXK3rbA3hGPlf5bd3QaiEwK4xY7Jcmtqk2mxjer3nPdw3gCkrtXgxfQB5olOlfpRAsA/T/5AKayPTmVkNch1vnsFDjdSimxhPzk9rlBzV28Ge+ErlqosG/ySl50pNtwrPFIQoqRTAYwRzggz9HJgUOJRxq5C2p3H5sjOIXAk8+6yfHQCwsXOMeMt1tkjY0hZd6cNHBCxTNUrd7CM+77faVFYBJE/otw7s/z/aPgw9l/ysygB/F4aVnE+JNgvjcNiAVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMKmLS/ZWFyZdQ/ap9Ho4dIUOBU1ezT8xny0ZB0Xd4c=;
 b=iz9hJyuGGnWk0X+PgozJ5P7nWvccMDnBek1IXyV4BSQxta4AoILYe2ESdHGNZxQHu4iz+dr2vlA4+rEGYKOuO6iHyhytM1/wgHsAA3R/62kPVlLkDftDOzvTUIJNPr9T1TcYNUojEsB/37MTbqVrs2QAtCXBbMRMwItikKT5Z4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by IA1PR17MB6099.namprd17.prod.outlook.com (2603:10b6:208:3a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 20 Jan
 2023 21:54:11 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6002.027; Fri, 20 Jan 2023
 21:54:10 +0000
Date:   Fri, 20 Jan 2023 16:54:04 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron via <qemu-devel@nongnu.org>,
        Lukas Wunner <lukas@wunner.de>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: cxl nvdimm Potential probe ordering issues.
Message-ID: <Y8sNfC1YQVj/DfBU@memverge.com>
References: <Y8Foj/12QNl0C96o@memverge.com>
 <20230113144026.000001fb@Huawei.com>
 <20230113144511.00001207@Huawei.com>
 <20230113151206.GA20583@wunner.de>
 <Y8hG4OyJL7l9oD2f@memverge.com>
 <Y8hJKcy1993SFLLJ@memverge.com>
 <20230119124244.000015b3@Huawei.com>
 <20230119150449.000037f2@huawei.com>
 <Y8oeYfyqNuSIIxCt@memverge.com>
 <63cad185343a1_c81f029469@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63cad185343a1_c81f029469@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0210.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::35) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|IA1PR17MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 84498251-ab28-41b4-4869-08dafb30dcac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0a+fsS2RNFbGhxj6FJyE+NzPrCD1Ety/NqoSIgpPIxUD9LPhRousG1GyGuZ9lIVhzQBed7021ec95aogVUc76RDTwrcfcJ7gUgLblYoFE22NK9rIS9imna1nHvJqeTnAfofXRi4notvIiRY5VWguTSKW81Hpy1njhWlPIXBlto+TxCr2yllAvHOwmjnsdVaJmH+Q6ms9PGNa7J4YPoStfbLWL8QcEOa7CYMfeEYqBjaWKmv0iRFEBxA8zP9pZ/UdSmYbo7flnT4aL90VXm5tk/nD3z+8tSe78IvinrUVJLppKupKh3ziAlXI/Hkn1e3LaYusvFlwMrETzwwTYsLxeo1OJWpDIizmLEBSxZnER97rAhQC6kM37wVJcE6GzLH2M3ZnRKXJW4Dup+VJjTYs4e9tfNetvR4Hu22Q4B/Lh4Sg1Ls1a1VxNLpIxC0AmPUF/IdrAoHHAqJBqDPCCI6ekXDka3tWYj+BcJiNWkp9kCAYyo6/x9Yos8hlfStoKzHJ68pyKCxXR3BnyNOMCJdE1KRXzTfZjESNE7YAdJR8KvBOXPaZTRkDrdXemlHS0QiQUbQXLAT20wnU+LS/dQf4coGtx45vmG2VbcSG47cVqBmvHyPSZI5+4BXcvkC6ew+WtEXuH5SnzY0bWsIGcKvBkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39840400004)(346002)(136003)(376002)(451199015)(6506007)(186003)(26005)(6512007)(6666004)(316002)(6486002)(478600001)(2906002)(66556008)(66476007)(4326008)(6916009)(66946007)(8676002)(36756003)(2616005)(41300700001)(8936002)(83380400001)(44832011)(7416002)(5660300002)(38100700002)(54906003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ybAvhj9UurELpHVMwe1/YVEZRD+oAseYqwBZz3goZm3deUj9fpVcDN87N548?=
 =?us-ascii?Q?lxlVo9RAM5SB1rA8uuFKprEP/0S3oEJmeIt/Dn34EzT8oc5yqu3oiWo78+Cp?=
 =?us-ascii?Q?HWdJpwjLKq7E7SuXK+PxRHwFb8j3JyEnTUoaK4zrdhGO3siOBtH8QJNRQsCM?=
 =?us-ascii?Q?PQwYZBEbLEUjRz9ZP9Lr6zGH2Kl3RCNMlr3pO+ZDlePNA96ADx2b4Bbr7As0?=
 =?us-ascii?Q?I6Ue7twfzYDd+dRL5o5E8PxwioBdiRL7jieeR0U18EalTjgvbQPfxBfhDpCj?=
 =?us-ascii?Q?BBVh3eGQQYSo+QkdBCykCzppsiEVeL3/gYH6njCTnNJ90st1cXlsnuMnHxtQ?=
 =?us-ascii?Q?ZOcXoNwBLRhqZ0CskuIBoKfyzZTRyzVcoBiFNxxFSj0zh35Gsin8+zrGGOes?=
 =?us-ascii?Q?SLLabuDtX55/wcAFIl1YnsfILGsn4RBYmhZiG77GZpWwa35DUZ5Yh7NHRY7y?=
 =?us-ascii?Q?MtUlTAdM/9MJQp8V89YtpMuG1XWcc/tqCtDiRZk/paq369DF7r8STeDpUyzd?=
 =?us-ascii?Q?kayyRHpfGG5cuTwiBD1PtrD00EUjX0IIpdkff3MoDk917a7lVHXt3tj8PUSk?=
 =?us-ascii?Q?EC3W0Qonje37n7TnbgIfTmTKQCL8cLoIIJnILr/Gvh5lPWgCm67WpslehWfx?=
 =?us-ascii?Q?yYqjjhgK1BBFCOdlrXFVRDvvIykvrs0F79WKYJ20w1v8auuIRmkTOYPJ19ra?=
 =?us-ascii?Q?CQMRPntuL5IHBQ2lTOP5FLYrlYQVbrb8Es8TIKxybkr9r6nEJxfkv4WADrNS?=
 =?us-ascii?Q?Y6Sroa7NZZrD5FqZepLYVIksH4HxS1NjbHNCLVwjqh4VuhAoAL1Dzpx9j9We?=
 =?us-ascii?Q?5pRIuxZk0vue+q3NslLBSpOAbC7uF93G/RiPVexeBxqx5T40+9uxetfT2hvu?=
 =?us-ascii?Q?uU1doxWjrjf64hCUftINSrJVGg8IOY1fHrOKr9McZT1+GNsVz5xMcvtm47tK?=
 =?us-ascii?Q?SBsdJVwAmQOPoMucRUEhBNcKQMMPByrnC5XXF1tmVC3ADVaT1F3NM2NaYJr4?=
 =?us-ascii?Q?4k7nqV6P8bBEXNbp5y4mJ3D9NqTttDVo7czg1u89GOzFmXmEoYL6cXqPSXC3?=
 =?us-ascii?Q?GnLit3KU4MGokkplQS4KkKCu3D+VfD5hmOk0VkIzqHj2bFMyi5ahgc4tKwKQ?=
 =?us-ascii?Q?v4APFlqgLDRF+aDHYF7AR19BcPcAxdjfYa9umivia/d2MClHvmk7QvuRG/Su?=
 =?us-ascii?Q?uRlZEgkc9tIkcVUQHMG3PEIepuGOHWoWeHPV65ovGsrEmwBi1Lx9A7yy9zhW?=
 =?us-ascii?Q?vP5SbRYTcfK74ukxkAbMJQUaRttgvrrtxGcTLSOuyPKdKFKg2qYrjGdcQ0Z1?=
 =?us-ascii?Q?yS5wje8fNK/oMxgF4QyQQr3Hzq3ObVT2nwHA8HDmuHavJqUzAsO6hSmDh8Uq?=
 =?us-ascii?Q?rhhiU0GpBOE9DXbO8C0tAk+LNtwXybwYa5RiflZFydqjX4a08ZJpTSP3owtk?=
 =?us-ascii?Q?8DLgpSsrUqIsFk+P3KOa6Adk5WKWo3yBhOG5OkaUAyC2FUis8QTHz9fW0iDq?=
 =?us-ascii?Q?Ar3uKQMJqJxFFCqp+BeuJmbpem2OXCd0A+Pk5svgNQEvFteero4xCBugOzvz?=
 =?us-ascii?Q?o8Q5sskaR0TaWjSDRSec2ZamIBbObR0TFYFyAJ3tZpKJ4wtdmzrzb/+lb9+v?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84498251-ab28-41b4-4869-08dafb30dcac
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 21:54:10.8439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yZt2/1FK+t9dsZLQA3W3tW/RCJWh6tpOLrWDhJvRPjMHbZwTdHh6rqcRCYEPGxluQv0kyLrK2bAu7UYm/IU+NOxu1HmHyrSmg+3MSGPjS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6099
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jan 20, 2023 at 09:38:13AM -0800, Dan Williams wrote:
> As it stands currently that dax device and the cxl device are not
> related since a default dax-device is loaded just based on the presence
> of an EFI_MEMORY_SP address range in the address map. With the new ram
> enabling that default device will be elided and CXL will register a
> dax-device parented by a cxl region.
> 
> > 	 - The memory *does not* auto-online, instead the dax device can be
> > 	   onlined as system-ram *manually* via ndctl and friends
> 
> That *manually* part is the problem that needs distro help to solve. It
> should be the case that by default all Linux distributions auto-online
> all dax-devices. If that happens to online memory that is too slow for
> general use, or too high-performance / precious for general purpose use
> then the administrator can set policy after the fact. Unfortunately user
> policy can not be applied if these memory ranges were onlined by the
> kernel at boot , so that's why the kernel policy defaults to not-online.
> 
> In other words, there is no guarantee that memory that was assigned to
> the general purpose pool at boot can be removed. The only guaranteed
> behavior is to never give the memory to the core kernel in the first
> instance and always let user policy route the memory.
> 
> > 3) The code creates an nvdimm_bridge IFF a CFMW is defined - regardless
> >    of the type-3 device configuration (pmem-only or vmem-only)
> 
> Correct, the top-level bus code (cxl_acpi) and the endpoint code
> (cxl_mem, cxl_port) need to handshake before establishing regions. For
> pmem regions the platform needs to claim the availability of a pmem
> capable CXL window.
> 
> > 4) As you can see above, multiple decoders are registered.  I'm not sure
> >    if that's correct or not, but it does seem odd given there's only one
> > 	 cxl type-3 device.  Odd that decoder0.0 shows up when CFMW is there,
> > 	 but not when it isn't.
> 
> CXL windows are modeled as decoders hanging off the the CXL root device
> (ACPI0017 on ACPI based platforms). An endpoint decoder can then map a
> selection of that window.
> 
> > Don't know why I haven't thought of this until now, but is the CFMW code
> > reporting something odd about what's behind it?  Is it assuming the
> > devices are pmem?
> 
> No, the cxl_acpi code is just advertising platform decode possibilities
> independent of what devices show up. Think of this like the PCI MMIO
> space that gets allocated to a root bridge at the beginning of time.
> That space may or may not get consumed based on what devices show up
> downstream.

Thank you for the explanation Dan, and thank you for you patience
@JCameron.  I'm fairly sure I grok it now.

Summarizing to make sure: the cxl driver is providing what would be the
CXL.io (control) path, and the CXL.mem path is basically being simulated
by what otherwise would be a traditional PCI memory region. This explains
why turning off Legacy mode drops the dax devices, and why the topology
looks strange - the devices are basically attached in 2 different ways.

Might there be interest from the QEMU community to implement this
legacy-style setup in the short term, in an effort to test the the
control path of type-3 devices while we wait for the kernel to catch up?

Or should we forget this mode ever existed and just barrel forward
with HDM decoders and writing the kernel code to hook up the underlying
devices in drivers/cxl?
