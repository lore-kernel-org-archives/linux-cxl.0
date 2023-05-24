Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9228EC77B7C
	for <linux-cxl@archiver.kernel.org>; Wed, 24 May 2023 21:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjEXVUx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 May 2023 17:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjEXVUw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 May 2023 17:20:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AEDE6
        for <linux-cxl@vger.kernel.org>; Wed, 24 May 2023 14:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684963245; x=1716499245;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0d4MH647bK/C/IHZ0Wwl7tvClqB3vWcdxtijk2TlOfU=;
  b=R116oz30EB9vslZVamL99l4cMDh2lbeQ4GFXqR1V3gmLRse1Ni6pBNtn
   QOKBp9iSv9GFajoyvlhpgZeB2aKU6dpzvI2BLKGnR+Q76Yms2pBk3u0GB
   j26pjbr1ZWGTfIHDLzFl9LrMCTXSwhyFi3ukghszW/E8ViKPP0MM9zi+v
   DwwTpPKXdGQt4qn53Oxg5S8puuyaMXMCIHXc68GKLN3NsMnpxhIVaMpmP
   jy3GWtk25TXLXe3DvjSXEXhFOTZmhDJuJ3PEK4e6R32jlL1voyPnF+bd1
   WMg1zoNZ8CgFW3uSnLyJDpqJfERLMSTvVLkLqrC0JxS4497Ye32NGThW7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="417158687"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="417158687"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 14:20:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="774397971"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="774397971"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 24 May 2023 14:20:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 14:20:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 14:20:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 14:20:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfxDa7X3ZBtdcdWOxEuub27s4WB6GiaiKPgrFU5KHsj2EHkjtL980SYhTA2Cw2KS2dsIbW1awt4AQdFJbMXpV3VHCfDf1nRJdxSXiCo3lnKyOuMvL0qNLaJ8qqKQcMkwJw+3FZzVEJDYab5SfHFQssqqREeM1qfs9LSRH0wZ51f4pLUXnYqOQy9jbbHkBIbSBjnE9CIW9piwpAa8sFS2u9RguyBgt2E17RfpqXFiHojAJG8xE9Cek1aHRnJ4N3o51ma0fRYjHzG4v5JdeXUZKpMJx3oohh7QbWx4J/EKyJNdtkGHcAkxWTAEMCJf9Sk28XflBUPKYRniGHeQejAiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nDrFP8iK8GaWh1Fq2ov7Af/uXBbBMN57Fa7d51ptk8=;
 b=XVfr43cqr7zOzTx5NliMS6caSBLPkXRuXLMs6uuYzugZMzxxf9Khl17zAPKJ4y3c1/JwwIntxFJLBoECbVhFnp6BfZUPj5btVBA/EGDeXxMF1o9taLLdNaLQl6hab3oiq1Ick5FwxiHvbbrEhfNethRLFwTblzk3XPwHpGRWDPCV1F/VWg1xVAKYGlcfkBEUf0bLt3MYTgZOq5Wo8Yol12JHLhjK9tP9XJTY5L/ZrF/C937OlYo3R56kuJXv3DO9trMGiYCu1ibJ9Q5OrmKjc+j6YEwvcFZgt1pquX8vuOcQGlZuED9qEF35mgRSit8qvs28ogV+0cQwPRD6uxfaNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6370.namprd11.prod.outlook.com (2603:10b6:208:3ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Wed, 24 May
 2023 21:20:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 21:20:25 +0000
Date:   Wed, 24 May 2023 14:20:23 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Vikram Sethi <vsethi@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "catalin.marinas@arm.com" <Catalin.Marinas@arm.com>,
        James Morse <james.morse@arm.com>
CC:     "Natu, Mahesh" <mahesh.natu@intel.com>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Message-ID: <646e7f96f33e2_33fb3294c1@dwillia2-xfh.jf.intel.com.notmuch>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <BYAPR12MB333685D98C43D5247BEA998EBD409@BYAPR12MB3336.namprd12.prod.outlook.com>
 <646d0892eadc3_afb77294cb@dwillia2-xfh.jf.intel.com.notmuch>
 <BYAPR12MB3336AB6A519C709DBEA75CB5BD419@BYAPR12MB3336.namprd12.prod.outlook.com>
 <646d8c76811cb_250e29456@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <BN8PR12MB3330831F2E666E9BB1319E66BD419@BN8PR12MB3330.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN8PR12MB3330831F2E666E9BB1319E66BD419@BN8PR12MB3330.namprd12.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 68857a2b-41e7-4ed8-c85b-08db5c9cb08d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yxLC/R3NYl6gfgbhUnH5SYHKrPgjtScRbEctsLa08QqjOAvUKxNqTJvGvKVjiqszDsj2ptY3JVyNV9gHRGNksiapeN7n980ary+shiI2v9EJh6IvRNV+E3u2WkxENy31vGgJG4F5/KiVlwSiwx5pQsI73ZeAbds4QqBK9WqEDpooEYv0NzVdCLI7bLym787xhTE4uddAqdDM8JSZV8O2fwi9D2Ir0liQzeuv1ZRxcHzLJ+88y9UoTOqFU80Ax54cUjFvIRfSo95BR84zDdOvfuG3cK8W5razieI4N1bJye3FZT2iynLFh1TjgrhEhA6irqUOZsVErfMAdBMP72js5ZXVhEr0cAgz2gLaW5Lh4Jow/1F3V/0+PWI/6R47e0tc0WorxYwXcEZh3yia27lFdpzUxAbZ8H96I/rpw2kEsogWe2JsQ91NaMeZEJotw1jOT16w5yeo56OdaqRjYMkHvnFvC8dqRGALf+NWTAkxaNk68Wb7y4d+0eqp5a3zqySJJPHtVtwquIpjO55es82n9Kk6A1znW9oJYEkg5Sa8EI2Y8d+/7va0E+l8gRFQCGM2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(8676002)(8936002)(83380400001)(5660300002)(107886003)(186003)(9686003)(26005)(38100700002)(6512007)(6506007)(86362001)(82960400001)(41300700001)(66556008)(66946007)(478600001)(110136005)(4326008)(6486002)(66476007)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+q4DSljNfocTvv48ZiW0Guq6JHsAZO3zy0bT+k81YWtx6Qa8c6rmA/PqSqWU?=
 =?us-ascii?Q?4XekkZ3grvzK0KeVWXW7bjAEMzZNR1ZjmrzKgs5fKfaWPwMoRjslhKTAyr5k?=
 =?us-ascii?Q?dxtC6HZ55gEVvjlLCtMtMdUSRQ+vKx/w02p5Bq9TaNM2vNbc0ex7U49mDAAF?=
 =?us-ascii?Q?WH25n2EDPug87ZtwO03ch7E8J9ifls7jmWz2Alm/O1RsjgIdKKHDUgXosts6?=
 =?us-ascii?Q?1bMREqQiost9la3knbnR+Kz+Itr/ft4inC5wVwBmXHIf9sjhmoiIJZwXPGZS?=
 =?us-ascii?Q?7grZOEqGGqbw2dqaLgtI+BBGNJYh3MoE4aiKB7kBvmRFdq8NCnjE6SvfGXDS?=
 =?us-ascii?Q?kR7g6fTyq9mNke6qHaOWwiI5iHPysJ8jEl9nYbrIX9WZ6V5TC92GtnQfQ/5t?=
 =?us-ascii?Q?vJnzgoVSAYb0CdFl1gE1O/XwFqyOG7QJvBXgfvQ/Al2Jwd4NmkAQ2xI0iE0U?=
 =?us-ascii?Q?Mepb7uPzZ9xZVPD55SfQ6HHLdVHr0AH60LeDFnt5JUwPzQrFaP7OlYcjyW8P?=
 =?us-ascii?Q?q+HIu4T5As0k4SdhfPom33UipS1ARt5UbKARbis8tOGlOX5URBFxF5lJzr1G?=
 =?us-ascii?Q?Up+bcOtkEulrhHPA5GQHAMbnlmA1mmd3VgRCWTMB+E8wMD4Ude5DpKM6TAfa?=
 =?us-ascii?Q?4i/ToWjWbVAR6vyYMvCr49h7XUsW3+gq47dZSgNK8qCWqg/zjolpHhIOiX9c?=
 =?us-ascii?Q?eLTy1zvrgUtgz2KhFniae4ytozJAeFyMKkk9HJTpu98D7w+0KtB2X1zDvrSl?=
 =?us-ascii?Q?2kwRv1dwG4Q0SLns4xvL6QJhaRvimzjp7otZ4+64znjvX9OSXGEjS0NiDIq3?=
 =?us-ascii?Q?XRTTz3JVkYWkKzS/6Ri4w26kt2tAYjhj0cJkhpHAp6ckcLjStDhXZO+vPAwA?=
 =?us-ascii?Q?NB9iG1jNnOHLWUCvK9NaBn+6G5CqE7DJuyTvDpwmp5LnXtTE6oeUcQUBfqXv?=
 =?us-ascii?Q?79s2ejY9C9chy7oCHOzmPAJqNI/Q4658k04JTifHE1d39Swbcp3lX5IZ9mHK?=
 =?us-ascii?Q?xQx6Q1JS97UXIxWwn8/NskBOCrLVGVrmIe2OaxYmpVhf3T88c3VdjQdR63In?=
 =?us-ascii?Q?A67LAvknRXwcodc7eoFJ/aYJhhBE/VRMFuvbO+9xJqF+lYY9HK3j3vdmFKK9?=
 =?us-ascii?Q?0qfvyj3pA3KAxiGJ41K6JjMooCEyOava5HE08TUdwO7K4nsQl1A0wbsZ0U7E?=
 =?us-ascii?Q?Mg7yYeqIhHZtxerbJEuQW6lbLOSiM53AwCrCl/qwTdMS+4yeHvxPUtZ01A0t?=
 =?us-ascii?Q?MSZnt90k2C38AfwWKX+4dXiewLX81EzuPxcjsFP4QSrToS/UlY1Md5ldeH7Q?=
 =?us-ascii?Q?8e6hTdcBeK8jRYhSmBG3NWK0Bdn9NJq9+AbP22MXIOdNo9g/ZbutvnUFIfhZ?=
 =?us-ascii?Q?mtvVSI4GlnVu3KL+q0nxxgB6z+7yLaXh2pA/umBfkl9u7mJy2NfZlAjPI97O?=
 =?us-ascii?Q?jgoyFQps4x/ZkKCl+CIDS98pecaCtcY4VRdt9OeE6NAfbrZpSY1IHUAU19uZ?=
 =?us-ascii?Q?FZ1QSThIAGHA541pbItPXCBKPUsdEP94Elcy/5U8aRuL5/zhU9y5X0m+Cwq9?=
 =?us-ascii?Q?qfS3iv4yh7TpPMrZevxAehVam1zM6aBj5XgdUIANfdyYvvgY90puCL/qVbx7?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68857a2b-41e7-4ed8-c85b-08db5c9cb08d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 21:20:25.7165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7J7xNILBzQdn8Or4BQkKsVTOGY6Z23GG6Ozh5dWqpNHZ8OlyvjK1ODC4La4aLZTN/JQQnLsVYdL+Yg1JpxM3+C+91oPGlrRTXK2fHORRY+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6370
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Vikram Sethi wrote:
[..]
> > I don't understand this failure mode. Accelerator is added, driver sets up an
> > HDM decode range and triggers CPU cache invalidation before mapping the
> > memory into page tables. Wouldn't the device, upon receiving an invalidation
> > request, just snoop its caches and say "nothing for me to do"?
> 
> Device's snoop filter is in a clean reset/power on state. It is not
> tracking anything checked out by the host CPU/peer.  If it starts
> receiving writebacks or even CleanEvicts for its memory, 

CleanEvict is a device-to-host request. We are talking about
host-to-device requests which is only SnpData, SnpInv, and SnpCur,
right?

> looks like an unexpected coherency message and i Know of at least one
> implementation that triggers an error interrupt in response. I don't
> know of a statement In the specification that this is expected and
> implementations should ignore. If there is such a statement, could you
> please point me to it? 

All the specification says (CXL 3.0 3.2.4.4 Host to Device Requests) is
what to do *if* the device is holding that cacheline.

If a device fails when it gets one of those requests when it does not
hold a line then how can this work in the nominal case of the device not
owning any random cacheline?

> Remove memory needs a cache flush IMO, in a way that prevents
> speculative fetches.  This can be done in kernel with uncacheable
> mappings alone, if possible in the arch callback, or via FW call. 

That assumes that the kernel owns all mappings. I worry about mappings
that the kernel cannot see like x86 SMM. That's why it's currently an
invalidate before next usage, but I am not opposed to also flushing on
remove if the current solution is causing device-failures in practice.

Can you confirm that the current kernel arrangement is causing failures
in practice, or is this a theoretical concern? ...and if it is happening
in practice do you have the example patch that fixes it?
