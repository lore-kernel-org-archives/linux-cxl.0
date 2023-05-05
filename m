Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA165C77B75
	for <linux-cxl@archiver.kernel.org>; Fri,  5 May 2023 21:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjEEVT0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 May 2023 17:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjEEVTY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 May 2023 17:19:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9F4270C
        for <linux-cxl@vger.kernel.org>; Fri,  5 May 2023 14:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683321562; x=1714857562;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=DyRbijD/jojvPJLbXxZoimoxRGzkSjMfGQPA/8mEBhU=;
  b=jEIxlnkM5pAa16sWyZwf2Fo2z7MivTNnVlPJi0XQD46dUriajKIQcO3G
   JeDFlRqU1+gYMdll7MI3t84OSxygSohxufxm0D3Wt11JaCIrvmzFu3psW
   lgNynx6y0KTFhJd4wXluqbZVAlF5Q+qlug13JdmtBkoT/uTCDyMHpVrcv
   3YFlSVQSGU/LV1bV5CLvTcGz+v7MiTq7UNzvwq8S1TXUaCU1gU/KAYBoH
   NPv9I0AcFlUk8U8c9sbvLKCvwgsuf3K8Clw3A0ifAzrdPb5hZmDsdcK2T
   uKZrjfa91H31kqM7TC9chPwHAZ02BRVlBT7wbP5c2n5h81cSy8ySR30zM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="333729870"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="333729870"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 14:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="841920654"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="841920654"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2023 14:19:21 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 14:19:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 14:19:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 5 May 2023 14:19:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 5 May 2023 14:19:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9yeIUIQWtizL97t3HgcR9Dhh7EkicnlGHwCaOVqyKjQbfuT0UUR3LVJbXKjLkPhAblYB7CVxg7tywO0gZHEwKFn60kazqmtqQiDfA/miam56kfflEeZJwcSKRlanHUOhCOgiehjpNguPxvSJh7zFP75XuFhBveg1Wpa5HyQpQlHT/y9o3yUJZF4WM0FTbTwxOww+V8BLtKb8rLy3cSg2ZlQE//ExqpuWhjY5TjzuM0HT0OaV//5YHF/+pgYu/7lukkgY2kk8znZ/d0WaRxXV+yH5rBMwTB8J6BUlXa1RXHEdTAggagTVkJiWEZAK8KFYfclhbUrd6VqzfzfFVyMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaI7SKuD9KzioG8FoakpdGRtDiKdKk2maDAcTPpv/9E=;
 b=H9picbIIStm4aZCuwGK+tW2zhmZmQZGf7M/lNEkh/7IsTV6oXpHlktqnBUIpwRZ2yGyrX4H9mluUkBDOQDBeRKOLguYqRGzroCTIrdpdbC+ms2PQ2V0mScF/vt+IXswyqVWRxFUAhrgr7EZJJxZMk+BrdFQSzyLbQnjyy3JngI8gSg1x95g/kE8wHImH1sfulKko7No+cc4UHGKIkwv+hxwt/uEkW4oSaZ56VOGddvZE3UpSlpxCaTH9NjWkNb1cEBaCH61ljd40N85eRBUeibdn/4qfBlTNuKLmYpf6X7fTlEs7bw83KtfD7me9XDlUazJh2SPeUwrxE6j6+QYtAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6775.namprd11.prod.outlook.com (2603:10b6:806:264::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Fri, 5 May
 2023 21:19:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%7]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 21:19:16 +0000
Date:   Fri, 5 May 2023 14:19:13 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Eric DeVolder <eric.devolder@oracle.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: Questions on getting started
Message-ID: <645572d181c93_1e6f29425@dwillia2-xfh.jf.intel.com.notmuch>
References: <544fdc40-0ff7-690a-d24c-3939d69c0725@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <544fdc40-0ff7-690a-d24c-3939d69c0725@oracle.com>
X-ClientProxiedBy: BYAPR02CA0038.namprd02.prod.outlook.com
 (2603:10b6:a03:54::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 022ab922-a47b-4c67-8a71-08db4dae615d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H23p8iF5EBmH5X0mmjYFmUXELklU6kscPmTirsWI64Cea8tbfP9oQBEf48PrS9I8vqQuJQ8NTLyNfPkwUL4Z8rsB52aiFYSsQRzJg3oJ1s7BJ6BnrmCfPaRT9B5kbP5I/zjpYXCE+0fo3Rx5CSVzBRTMOv+VNCl3VLsjCy2Cwx1+5zWknuGqIPIrfcdgT41H7E4HTHXtZKPLQynda+flkjKkJFr5kUTaCgMYKmU56db2emCmuOcvdx8SesxpIU7cwkXhI7obWC0D6JwB9+MG7Bj/lcSkMyo4kAtuqbq+ggricRzIAIaakP9WLmKKxDB2QNxrii4eGUY1RuusU+BT3puJyARIKAfEp2FAH1YDM92lEIOobe+j5B6to2xv+JmwD0inYLPJQHQEF5Qx3YdBxMlnI04tW7cVHgS3J4LwANTAYh4mz/MnLUIPSWAAC6S/ZdzbGHTLkilhBsHRTsHG4WDU8MXke8NLlbwGH6KQ5nqokhm5PAGHH0Jx3/fRetES8oT7KRgAofjCMrJJKgXWKLzFMByFHdHsiD+GCHvAU5pCnWQtjGTcdW+2DJ+7brc03vxEuJNApx0m0GDPXboMdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199021)(66476007)(86362001)(66946007)(66556008)(66899021)(6506007)(6512007)(8676002)(6666004)(8936002)(5660300002)(186003)(316002)(41300700001)(2906002)(6486002)(478600001)(26005)(38100700002)(82960400001)(966005)(3480700007)(9686003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FJ2U+umlw2zq3u3Ubl6r59XUV6Z5ccuhhSmMevPlo7lH1AwJCAIMMNyKRvTi?=
 =?us-ascii?Q?qpGfuflwt7K60YZgnJB3bqkYmtbkf99vG2lqBDZc6x2z6T8pxLce/0JQhWc/?=
 =?us-ascii?Q?BTHXflv/j/N9QA4i1H4PVtfz7Fk5jcOrbOjjiGp44bnSuXOSv7jIgtyDVLTP?=
 =?us-ascii?Q?LxWF2Xqq9mlL0Stn2yitazmgygkLt9oss49XqmMGoMkI0cSPEj6c7eB/9RUx?=
 =?us-ascii?Q?DeOOETYZbJrq2RIf5Cji4kkdbbkSi0qtznqBxfJ5i3grVukRK7u9SMpYi1P5?=
 =?us-ascii?Q?4lVywXVKV4Y6uFGYDHdVMOMlTfwgVgwSiOVsfFTiLu99ZcpByzAGOhbshRw2?=
 =?us-ascii?Q?bpchlOQCqhyubXkgIyd7kD/jlgDUg6Xd6ILCDkl0F9x8TYf+f+V1+3bW1LPS?=
 =?us-ascii?Q?KIwjgr2lJwxrpSoXSxcfSXNl4g33xUDoehoIYcgzG2mVvji+wdaIkwQgX06U?=
 =?us-ascii?Q?0qtR/4BDW5yxAKeW4AubZetAL+qTY6Z5k5myn4NW0AjXqV5ImaeH7HI8DmFC?=
 =?us-ascii?Q?GrShSECr6ycUXb3O+TwLMqHQFce1UWbHeY6pL8tz7nUJ1E+PiIu0CjNGV/k6?=
 =?us-ascii?Q?uQYQnbRgWVQUw0dYX2LmoosrFN9KrCuTpJ/1nBhVbVDPH9oFO67BblW/RklD?=
 =?us-ascii?Q?V/mONYAbhGZDxIvVUS9zCyNwkjm22DfkV/H+WaHaq1ro334vO75Yoo0ciVhy?=
 =?us-ascii?Q?t5t/Unw+/0clBSjhZ7GBmcR6xXy26vdogEQ41EAnAk+YgHYF07Tynh/xrUim?=
 =?us-ascii?Q?CBD34djBw7RG3TzKzDD4E9RJWqQ4yIKBjvSOhegbd9CMWh6QRUNTcaEUc0Ce?=
 =?us-ascii?Q?7miNeCjHFv8R+XGrxyCNfnc1ZTkwu65Ucb48ta/KhPVWw3p5wYr34oAnAHHt?=
 =?us-ascii?Q?yOHclSNvlt2GN6al6VZnrBlicAHFQEdpwld2pissYDgNN53bDm64Mc3UuCqG?=
 =?us-ascii?Q?EKTnVpwjLafuaIFiNXf+f5B8CXQcA8vZBbVLJ0GN6BR0Xvl6IyLWoLxkqmiX?=
 =?us-ascii?Q?yFC5WVEA+emKiWQ+6bfzXgeT89yauWWvwqJx7XUdRKkkoF8EHQNxqDRQHIJE?=
 =?us-ascii?Q?72YM8JQbb2dS8tBMtPdLoOZnK0wBqYL+m0YGVxNfOha9Y8lVWIUrDE/8pAyz?=
 =?us-ascii?Q?rFRNATrilcRUY9iMx26J7vrvJ4jHr5H5936Gn129IA7kjl8Xddnk5cHe3WQi?=
 =?us-ascii?Q?Y8VULqG40Id4LyFzGSvS8i04rwRh7lhXAGPgaRB/VM8OeFnjXQMFNnCF7XNE?=
 =?us-ascii?Q?ce3EtuJnymK4vPxbTzqcqdKxDYazQA7YqynNsGs5WIdL1Yu0KYnKCjjwva8z?=
 =?us-ascii?Q?wt9yY84i67FRLsIJlsnKQ2v4HqKQYdMtfmSq+xazi9Be3qHI7dYEjw4radWO?=
 =?us-ascii?Q?r2e3WD1fn5zrgXALSvRTXf15g1vH+PEZDA7NmdyQSiWkPBJjuQ/4lgSJEWai?=
 =?us-ascii?Q?16Kl+s00qne4v56r1JMxL+dhoEe+1JINIbW1o6czDjPNTdpYt5+dhTJlc/uR?=
 =?us-ascii?Q?0tQmOV00ZYeiNt0cPB/lVXTe/tnrQb6T6cqTx/DafYmvzGizx9gkRn8zLJNE?=
 =?us-ascii?Q?5MSakr9FbRof5KTZMeFgoYbWBxzPgIxDhv9gyqpSlsjF+JwKtPwk9FtWrVHr?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 022ab922-a47b-4c67-8a71-08db4dae615d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 21:19:15.7247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBE03RMWbLWPNBBgI5vK5Q7AVSAjIv8divELjQo8C09BVxV5gDPsy3TY3CVA47cC/bXabJ92MDcf6Rk4m4aiwhR/4gNn/zV77uwD2wtclBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6775
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Eric DeVolder wrote:
> Hi,
> I'm new to CXL

Welcome!

> and have spent time browsing linux-cxl traffic to get an idea of where to start. I 
> thought that running the tools/testing/cxl was a good place, seeing as I don't yet have any hardware 
> on hand.
> 
> Through various nuggets within the linux-cxl messages, I landed on the following:
> 
>   https://docs.pmem.io/ndctl-user-guide/installing-ndctl/installing-ndctl-from-source-on-linux
> 
> Following the instructions within, I was able to observe the running of the CXL related tests.
> 
> 
[..]
> 6/6 ndctl:cxl / cxl-security.sh             SKIP             0.03s   exit statu7

This skip is intermittent and should be fixed as of:

https://github.com/pmem/ndctl/commit/82a0cda5

...were you running with that?

[..]
> OK! Now, if I repeat the above steps, but with recently tagged 6.3
> (perhaps thinking it would yield a passing suite):
> 
[..]
> at which point I've lost the system and I have to reset it.
> 
> I suspect the faults in udevd have something to do with "plugging" in memory, but I don't have any 
> ability to inspect after this point.

Yes, good insight. I have this setting locally, but the instructions
need updating that as of commit:

e9ee9fe3a9d4 ("dax: Assign RAM regions to memory-hotplug by default")

...the test requires booting the kernel with:

memhp_default_state=offline

...or building the kernel with CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=n

> It appears to go boom when attempting the first test in the suite, cxl-topology.sh.

This is because v6.3 adds a preconfigured ram-region. The test validates
that the region is auto-assembled and ready to be onlined. Given there
is no actual physical memory behind the fake address ranges used by
cxl_test that final "online" step that would happen on real hardware
needs to be skipped.

> So some basic questions:
> 
> - Should the above sequence work with upstream kernel?

Yes, and with memhp_default_state=offline and ndctl v77 I get:

1/6 ndctl:cxl / cxl-topology.sh             OK              11.90s
2/6 ndctl:cxl / cxl-region-sysfs.sh         OK               7.32s
3/6 ndctl:cxl / cxl-labels.sh               OK              10.58s
4/6 ndctl:cxl / cxl-create-region.sh        OK              18.40s
5/6 ndctl:cxl / cxl-xor-region.sh           OK               4.76s
6/6 ndctl:cxl / cxl-security.sh             OK               4.23s

Ok:                 6   
Expected Fail:      0   
Fail:               0   
Unexpected Pass:    0   
Skipped:            0   
Timeout:            0   


> - Having noticed that the nvdimm.git kernel went dark, I thus tried the upstream kernel. However, 
> from the mailing list I learned about https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git.

Yeah nvdimm.git is only for dax and nvdimm maintenance. The branch you
want to track for updates going into the next merge window is
cxl.git#next.

> I have tried the same sequence with this kernel and a various few branches/tags. No luck. Is there a 
> branch/tag here for which this sequence should work?
> - As these tests utilize a mock driver to emulate various cxl component(s?), I have found that there 
> is no need to run this on a system with CXL components (ie real hardware of qemu), correct?

Correct.

> - Is there other documentation for learning how to run CXL tests other than this pmem.io ndctl write-up?

There is some automation for setting up a VM to run the tests in the
run_qemu project. That builds a kernel and root-file-system and boots
with a canned config that is expected to work:

https://github.com/pmem/run_qemu

I tend to run a custom VM and give feedback to the run_qemu project as
needed.

> - Is there a better/preferred way of running tests beyond this? I've seen reference to kdevops, but 
> am equally confused as to what it can do (in part because it appears to use the above mock modules).

I think you're on the right track, it was just that memory-hotplug
setting that tripped you up. kdevops incorporates tests from multiple
subsystems I would defer to Luis about more details there.

> I have seen the email thread "Usage of tools/testing/cxl" started by Raghu H, but that didn't seem 
> to answer his question (similar to mine), and instead pointed to run_qemu.sh. I've started to look 
> into this, of course having some difficulty. Perhaps a quick overview of pros/cons of: 
> tools/testing/cxl, kdevops, run_qemu.sh (and anything else that CXL developers use)?
> 
> I greatly appreciate insight/help in this regard!

The CXL emulation in QEMU is the primary vehicle for integration
testing. While cxl_test (tools/testing/cxl) is for regression testing
the kernel-user ABI, and mocking up topologies that are out-of-scope for
QEMU (like CXL 1.1 "RCH" topologies). The run_qemu project aims to
automate setting up a VM environment that deploys the latest QEMU-CXL
emulation as well as cxl_test. kdevops has aims to be an all
encompassing test environment for multiple subsystems where cxl_test
comes along for the ride.
