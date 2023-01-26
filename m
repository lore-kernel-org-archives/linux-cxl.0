Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B425C54E94
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 06:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjAZG3X (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 01:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjAZG3W (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 01:29:22 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD02740BD9
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 22:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674714561; x=1706250561;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=eBsm6lSypKIND4LMCuk6TANMdV3sjEj4/nRaCgyUdN0=;
  b=MSHZUKtkFFhaNIG9dwFO+FVXaM14cP4okVKSiHB9wXgPX9pKU40DmNbs
   slybDHV+QbAQ5/kMXzUSCino2cXGnKPWMk91e7MJyxibIITUdwkBsLBRU
   C/0eiBgE6nMS4jfMLJmMkuH36FQy7ScXR0KDZgLc/uxHJUarcp5lP/OH7
   UWeUCtqxmEWWQjlwCDQeuvPBOcQZukGMT1IG7iUUTVT6nHnhNVXgVZoF8
   tyGghPJ8xXe1NjBzQNxyzG+wOuYGhhhdoxroD94JuycnO2GYzwZNaU2Vd
   exUAU+B4dBKJOh8wDat88dQPpzrXc62yjo9qJKJle70ssYnBaY0Nq2J2X
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326781438"
X-IronPort-AV: E=Sophos;i="5.97,247,1669104000"; 
   d="scan'208";a="326781438"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 22:29:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="771017507"
X-IronPort-AV: E=Sophos;i="5.97,247,1669104000"; 
   d="scan'208";a="771017507"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2023 22:29:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 22:29:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 22:29:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 22:29:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngW0jhNLLhCdZ/ICy4mZGRjbC8aaZccqULhLtJyqHUATg2WCFPN+O9aO58Fzkm1EtIQnsFF/94KtGkgpPPX+NDYOSKtUj+tK4sFLCw759WZjUHDMb2oebqryAtdESrAepDUsf/TVJh1UyGYFeFmKEGJ/HKqO3VvO/e0PZNRRSWjdx9v74Ef/pdRcPt6cBBCltwCQ93Z9eOZbCc1QSmKDTOcJ0y+wjvjYIAgzOLE0gPyYOjDUWpKRm+Xq/aCQ76UZT1e9QnTQbXB2fQckD1JRaBjHHmeHmhd9LXPr4GgRaRCLx/eaZeNajd2RsxLCyLHY/WVzhnS9owRnB61F7iatzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmoXQNYuhainFD+BIWBmXmvke1LGVk7+FwSEzz9bz14=;
 b=K9kM9jE4tKo1JhMbo1jPfmenxErPx9sTSuN5EYdOmh6/VPfEAHOIlPizZqW+Ge375Fpijlf9Z2gSCDYuPD9UHaQ++2Mv1EKFOI9HxRjWxyLTv9xb1DprjnOBUPW2nJwYw9G8SECj7EvsFS8++9aUzKZlgnUUSNtn1VuN9UsoazgURQq3rBRd4czuewAWULiyFWkqFqVgVRXnwk05FquOK3JWtaK1/9KvjLItJYyhhmjgL+99Q3dZ4con91Wp/MSq4Vw0Xek92Nt8Xt8s84m3PEwJ04ZulYqXr0y+/esdPuYnT3KUveoWyH/kRJnv5YZ8KY+Z+/McWlQ625pDydztxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6136.namprd11.prod.outlook.com (2603:10b6:208:3c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 06:29:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 06:29:18 +0000
Date:   Wed, 25 Jan 2023 22:29:15 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <63d21dbb62f2f_ea22229441@dwillia2-xfh.jf.intel.com.notmuch>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:303:b5::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: ad79b7b8-ef1d-453c-bd61-08daff66a6ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTR1GDj2finOhwts3K609puCagt5ANqn6asQpW7NjALZAlwQp7V323Cv6jha1nl/9G1YBSSSZnNb1OhglafnMvmHwiuMPJq4i7nN/ZYpjMrMJbAt7VL2Wo/K9qNehR11uZViBcYXclH7d3dRRfOQAwXtiSicF/CQvKo94a5E/j/2am8jKP/A8XKmuZl7O5EwyUe4JlrL0O/KhznidB36e43f72Rptfu1PWKthOJUHJTVvJsl5qR2ENo+V4F8Zi7Wspr6DWPx8JH5yJQlvC2mkThGfuONIrxFAkxQUGNjjztxyIRrTd3FlZ0QkDDgqrJ8RU5QaHuMP8wYel/1uilFAnqm33mSAWPymCctKRSfM4Zo1Z1rAjH3XS6W3AYaidHsoZke8qvtBWFrw2AGoQcbPjxTJbEtBn24DZdzAJ55zUP2JN3mxv9B6bAGPUks8JKaKPvKqry0CY65Wz3WSqSrlPPM6wn6IX/4ENAgxnZutAEYp9stB/86acofV0w4OB1zpMAvkB3hiLKfDaTLZXAC82R7fp4EcK+Bvg0zyai6JIXRNNfRBJB+6cr1AACny7EsMXWxSCXK/gLmu//NOuFH/wYxYqcGIW4dxnyI2pECnU7YLZa4+MLRdzMbaGd6CDO7DyVCaDf4gki/97dI8/fvWHqiuqQ0xSalyMXQ4uW27qwBV6PKauuqFhDtLdsFkzXN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199018)(8676002)(316002)(6666004)(6506007)(6486002)(478600001)(966005)(4744005)(5660300002)(2906002)(66946007)(66476007)(66556008)(8936002)(41300700001)(82960400001)(86362001)(38100700002)(83380400001)(186003)(9686003)(26005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aT5rluMcjWqSzSixWP7RD5bkOK9WT7OCnfc5uyZ8e1IryYIPAuirmQI4L0Gp?=
 =?us-ascii?Q?Lfi9ME4IcM5YTNCKuFJbjNE/wzfUeY+3YrDCznAYc8g6EY19TW7cM51N8uLs?=
 =?us-ascii?Q?mtTRLMfMW1y6Fg6D+lvcqRM4Gdq4poVobZ1p+fE8O4EZtYxYxWUwAlZv3uxI?=
 =?us-ascii?Q?NEQBYLg+vZfan06+8+Iqur8KUxEdao0YeJx74DWD/YTzcLddiznbcfI12kwq?=
 =?us-ascii?Q?QmrXC49Iae9lY1knu9Htq7I9RGdz+99gAhjilcFJodxG4EpkDNaZaXzxgkUj?=
 =?us-ascii?Q?T3Igq38/tZRrIcoiocuWosf+TEHJyNceNkp+JxwRGxB/xrUywQpijlkLVIxw?=
 =?us-ascii?Q?Gq524FTZDtaiUUp9i1xHJy6YthIoSlQE40ETlhl0Rhfg4v4/DuTDA6uoKjFe?=
 =?us-ascii?Q?hH8Sj6VeLVnN58kmk/CW0x5i9oc1F4MAEMx7diwxdk9PtjHGnW54FMirgOjS?=
 =?us-ascii?Q?mXRrdm6dSg++H1lJizD2LtgytCZqrlQpdxx8WEDKkJtgcTOS/y9/dFozxn8f?=
 =?us-ascii?Q?4EJmHh4DVyAfyr7wZULDoaheTIQ5pDO/F1JqV6yi4nrKoJ+RSX2ZRVmwVzn7?=
 =?us-ascii?Q?u7Yl5QwoY4UrkNX3JHSR2lE7PjCJfT0un38pjy2+KtMYaq5xeQ0wRPrtC67k?=
 =?us-ascii?Q?vXDxWxmpBJtqCM1XB90iSI1L37x/BnD5QZoRzom/a7DqkbzJFScnWOgnFWzh?=
 =?us-ascii?Q?B4eR8fLFiSBuXF4OEw0l0aNU74TStZ/duIVZIpxpYwwrbg99V9szLwOlD1qt?=
 =?us-ascii?Q?DdNomC3LFmj7VOQwQTzS6Hf8f5HMmiiOepASDnNm/j79UYG7NoBmJC/x0VSF?=
 =?us-ascii?Q?scIuoy8bSBs23SNhWGmTMAwAmREbbeAtd02iMLtQ5fjYZg28hrbSW91rmWl+?=
 =?us-ascii?Q?KdxYoYgcsNqgTT4z9MNmmtzGxMFhvAq5QklXcyHBMLAfnMVLhfeNC4QstmX8?=
 =?us-ascii?Q?KHAg2WbjbqYt6njrFRHTNH633oarYFMREZmkh96PHgn0ZpoV+24e8uZQoGLL?=
 =?us-ascii?Q?pPMxeCCxuK/cj3D6jbIhFfTk37JxVS5C0P4Kbdy2s0550bsXiOYfAbz2h5uQ?=
 =?us-ascii?Q?VKVCAm0QfYHC/xv40jo3oR6IVfCHNp852clGNaH0ZbT47WnB5VxF4q/JLdZV?=
 =?us-ascii?Q?id1kYZFFseBQkFenak9aPE93zR1KMJWIyc1g+cDeyrvyNnVCm+wR+MIgUtur?=
 =?us-ascii?Q?qyR322wHHUi8RuzxaWD4vcVx+AoFuywDXsnWTP7nUqMlhn/c8t+THJLg/rGA?=
 =?us-ascii?Q?Wx4xsoKTeTponJsbVqj5nL2+27XO2lqrbvww3y8cEKKhviuLgcZfWND8J82C?=
 =?us-ascii?Q?P2oIhNmZEb6mEnlF8sQeDgXEyCz9/9O+VIIIMm2y8pSn1mNKkdPPQ1PR6vpQ?=
 =?us-ascii?Q?3LelUUl0IA2jqfXcmnmqBZKDxh2zK9ecDiUqdxLF9jRJ8qOQGDnVsL/ZW2jM?=
 =?us-ascii?Q?kD2/KuRTpK8xzBkNtoDXEFb4Tx17fawX40aIXSiZZsTmHqlO/ul0bCbBMMQO?=
 =?us-ascii?Q?1R8PFUYZwIGU+X7+L6K609XT6IJpfGlec7qEQ26vvepb7RWvoZrJExldCP6p?=
 =?us-ascii?Q?YelE7bHuFaKbzqfG0BjnhuJRcXjR2qo0iOn36GPu1fIenmZhkFP5Arff5HFJ?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad79b7b8-ef1d-453c-bd61-08daff66a6ce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 06:29:17.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRILx/CGbSyjvATkAL2bWyo2FuTx+IkCojWcpk+VOxIvRgwFRfZRKq4demIklEt2NImUkklsw6SCLdWL3N/lbiMZttDElbIk9K/xfMCfm+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6136
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Williams wrote:
> There are still some sharp edges on this patchset, like the missing
> device-dax hookup, but it is likely enough to show the direction and
> unblock other testing. Specifically I want to see how this fares with
> Greg's recent volatile region provisioning in QEMU.
> 
> I am hoping to have those last bits ironed out before the end of the
> week. Note that this topic branch will rebase so do not base any
> work beyond proof-of-concept on top of it.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.3/cxl-ram-region

I also spotted at least one bug-fix that needs to be broken out and
submitted separately, so reviewer-beware at this stage.
