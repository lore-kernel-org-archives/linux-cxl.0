Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F31C77B75
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Apr 2023 06:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjDRGfY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 02:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDRGfX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 02:35:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D003C0E
        for <linux-cxl@vger.kernel.org>; Mon, 17 Apr 2023 23:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681799722; x=1713335722;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9BC1TdLCBleedc1hBcS9sb1k5h2NUsfpMLZgzOAi+Xo=;
  b=ejS+UCk8jVXu98E9tMkzd4tVnBEUNKdVz2uLkqi9+yNQO9QaQRzWzeTl
   DUqJEzDVB8lWPfgpGB084EUDBU4wugjJSyk79b30Pe7bmlTlkJAZtcEsV
   WMZAMHoIxzszvwuPxB9H9BfhPG9bLAmmpn7sRj/1DxWcfChBCJBSo224B
   SuOozT65P2XJxEIs6bEQhIRPki3CVoKc5FxE3YzZ+F8coA6ZydK1UWUHs
   FD0fs0jFDOIhTxFSciIddqhEPgf6t73ivcnG933ZZmebKCcHU/5ooRtoa
   2ssIaJF/TnJr25ORHSZkHgtmKT0NdYBqrnN126tQ+Oi4WonYo5zKvj00s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="347839146"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="347839146"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 23:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="802430326"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="802430326"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 17 Apr 2023 23:35:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 23:35:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 23:35:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 17 Apr 2023 23:35:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 17 Apr 2023 23:35:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxdEQcyRdSALaeM0Vx9y3/4rGG34saG6puUaz5mj505hWjS1MNkcg4/et6HLK7ktfX0qYn1y6inyYqYLQrqUDibDXpwMZEW5/E+1iovDidlJP7kfXEu/m8+mKMooQvMJe3zNRm4wLv2CFMB4s4w8kNWBIgUEpyALv1O2VNv9cd4DaUd7hvJgRLlSd2pLj03QrNBxDHCMjRF5OPKK4udpWp9mnTqk/D4yK4vE/ZARs5DrZYAu62XMAcg12TybVegOXeyjdKsM8LI4zGPIS/2rrA3R5fogHVuReBW6UUNCP0uWWByvn4tPyuEYvJfxfNe6D3+/HIuxsU6sqxVGhtp9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETUCYMyOC2oEObzDuEXd0NValz/NKZKoZo51i942S3Q=;
 b=D3F+iYHhb913R4ImjvgiUHZWAZvAj/KDVozkFEfmAMfqItOnA5Q0yydSI/Xi3Y7FrQVuRivaCc9s2b8TQwcmMNwxgb85WSrcJgQtZl21/EkJfEPeNutinWGyTTGtRzGh+E5eu3YGqi5SPhVhXUlyXTykj74IDMeDqSLH8Q6CwnIpKWKielLT2rbDppJLn006J8cfeuIrSeW1U44LnUGK6zn8G05/9ql5ZTwYX5UphZPclpYU/n9FOX/z2v5RLs5rueYViPcwYtQfJJ+Kalu1pgI3V+9DFE1W3dUiUmaLvd0dqRvCzSxj2y9qozLjtmyejD8T7yaqR89aRR46CN5pWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7995.namprd11.prod.outlook.com (2603:10b6:806:2e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 06:35:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 06:35:18 +0000
Date:   Mon, 17 Apr 2023 23:35:15 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        <linux-cxl@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: RE: [BUG] DAX access of Memory Expander on RCH topology fires BUG on
 page_table_check
Message-ID: <643e3a2344460_556e294a2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <ZDb71ZXGtzz0ttQT@memverge.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZDb71ZXGtzz0ttQT@memverge.com>
X-ClientProxiedBy: BY3PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: ee754992-be6c-46de-e48d-08db3fd71355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YvT5Nqi7l4RkU3qtgbCjHQ18E6OAWd46SiS1iTlom4C3AdmftBakShnh9i9Ca5I5cZaX4W0FVLIZvtz39/pAtdKbMlNo3r/Dk2ePFQrGKbq825s2k/TaivzPCL0UBhi0CgPHEcBXUVX02n7SX+/NKq5uiMWi43OuULDfb3//5bvidhADTz+GRirarqQTzxCKhXeNOz9arkF5r0RPOF+dCRCGRxFMNs/BEIAKNUidSqbNQ4tnNzq4RxaYPdzjWGFiOGMbYAAPX+c5tdFkiwQseRt/KgJ4mfu87dzI/YhnZxKLPit6hxkntuXcRRayh6s92zf0bN7v/AvyU12zQeVhU1WtOLkCsAuR9HRSEP1Pl9YObGUDdQCx83JOOq9glPP+yxZLcwYC/cmfNtzABYMhR7CSVn4KtdNkCC69W7hlejWlaXLAhZwzRcbw4myDRykq30YMRuNxVBZGdm5qZ8swBHzBGcdqRFwNvXZlvJ8bI4w8Ea3f3IqMzEBvDFfLA3YYB+sCxMqKIm+jCLJMP7GZ2Dbnue9eiPie6ZFw9FRKvW32vowAdjodNCVxn/Auzrev
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199021)(2906002)(8936002)(8676002)(41300700001)(82960400001)(38100700002)(5660300002)(86362001)(478600001)(54906003)(9686003)(6512007)(6506007)(26005)(107886003)(6666004)(186003)(6486002)(4326008)(83380400001)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LoVlOHTDbO5FznAiadqlqDLsmF3Mg4zbb1jk62WDhxJ6yEI6kwQ8iBBCr8+r?=
 =?us-ascii?Q?5Huqz6NPXIbo3SIYqIiBi6lg697AV9ibtfkJ1FiEHF8L8OmUz/qV82VPLCQH?=
 =?us-ascii?Q?4MbIJ002w6tAiJ5abyBvy3ONtVr3pCF3NYSkkTcfJxmTgbBVIy9XXOWqZipF?=
 =?us-ascii?Q?g4iYvrmteusgcF11IFuAxz3lqGRVXl1D2/sSH9O1Ub2fuqGB3hTVG7Y3//Aw?=
 =?us-ascii?Q?IRT7FcFjyCM99RoN1TcAr2mHltgjVUG7glZcrv3WTCXZS/UKaxgdT9VmVOAv?=
 =?us-ascii?Q?lGhUFyeuqNIjO4xjHeB/AbMDWa1AZm/rCClSQjPoTRkFqZJK9jY29RONAsTw?=
 =?us-ascii?Q?qKQjEVys84rLWEY0GcZJ5tiX2jXE84APP618hsTwGg59P2YpxMa60BJSuI5v?=
 =?us-ascii?Q?triHPBni+RASHZJTNGtPExUtJ7WVo+X4CApCi5eiNhsTtrGBkcF0gj7moPIx?=
 =?us-ascii?Q?G00P+30QDmAkWsdjWAvcpFjyfk4PyEKobd2e6Oc+Csj51FE9moNQffUVlZ02?=
 =?us-ascii?Q?ytQgGdrxJ81YwtZtUq36SlMP1OjEPZ/s2fggLrRXzNjQP2rFF6CE9J94+zzZ?=
 =?us-ascii?Q?er1dR68znntCVuQxFtWc5V01nt/mlzEaSRs5HbOyTcPB/bavfZGaAJYXrAvI?=
 =?us-ascii?Q?jpIcmuEXnRz0NpCAiFZ2gCnaNJNjmDK3SC2AVdLoUaA9+pTy4l1DZb7VlFCa?=
 =?us-ascii?Q?b53MQwyb422K0t7elg5CXmk9tMLF7CgPNsqLhk4jKnsZf9iflRrXFswTRp6o?=
 =?us-ascii?Q?1eaIdQ7QYb2pWtWE/MkjecAU4jA8LoQ12vpaTFBZXOaJZi6lP0MNhAAJmBmU?=
 =?us-ascii?Q?ukhUwTIHOBdIIu/DC+GFu7ROvUjB56MpKHJ/sHPhKRC02Xl0ceYk5cBSUJsR?=
 =?us-ascii?Q?9wRBdLiH4Yd4wlZVchAiWSV88UQRcJbruZzbP+ijR7PbhaZzxBFebMYOM4NC?=
 =?us-ascii?Q?5QUeV+HCfR1dd/Hx8RVRKGJ0eT7Z92kyxa1JcbNsMfuti+Mzc3WD9YujsvR6?=
 =?us-ascii?Q?LAxMiqxbYhbW4bmqSLBegLpxXC0qyGnpEOlbTFzEsuFvncR++vdzF+PtSzXU?=
 =?us-ascii?Q?SSjKtcwI0TMuH5rYSHXKy2vzmzmnvSNmL/9askLFDzuwWh7vxkXc4TBJzOl9?=
 =?us-ascii?Q?8S7zAfKfvzIJii3xK89dYrdxzb+Opea99VZx1Uw78ksZVRUDnDp8sr8FsYKX?=
 =?us-ascii?Q?yu9+fNXriqGnbcI0ZRSszcbqzT8q8pJj2JoL2JhfxZn/Z63Q0R5dMDMbxLRV?=
 =?us-ascii?Q?D+SQbqAwMWDfniQ70AOYcOwmmXezec+0gEDE/+Xxm6CdjEttN/t+BpB7tdVn?=
 =?us-ascii?Q?LkTbBC3adiTD3JRe10DlKafLPeTtNg+sS5Whk0pd4TZ1ajoVoEo/2BCLQu57?=
 =?us-ascii?Q?Tsb2J7BcwiXFAtcJKWZcfVgUmHrvcUH3rZEy2QZJBO2NjYH8WLc9iwiCPyR6?=
 =?us-ascii?Q?LCPhhHs2Izs/24qHoFbCtLEawuhEfsGIPuM2tdWsYRRkG82pufLTNbvR+Lig?=
 =?us-ascii?Q?y4aBk1G6fCb3Cea+dNP5l/22ilYC0YcHZrMjbGfQXU1677ht4eKx7S/xHOzw?=
 =?us-ascii?Q?4Hill32U3+IEF2Q/+nD8PQrrABafzE+gFar047+a3bmg2fJe64l+RDvbKCva?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee754992-be6c-46de-e48d-08db3fd71355
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 06:35:18.1789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1YbY9a3L+cMpfrTPhzfJPDZd4wSNqnwt0jHS8M1ZyU6S43apwG/+763ASU27T/6JDjnHbioEFKaGPtY7WXChbjTsEEJPENLpWgoqpVxqiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7995
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Gregory Price wrote:
> 
> 
> I was looking to validate mlock-ability of various pages when CXL is in
> different states (numa, dax, etc), and I discovered a page_table_check
> BUG when accessing MemExp memory while a device is in daxdev mode.
> 
> this happens essentially on a fault of the first accessed page
> 
> int dax_fd = open(device_path, O_RDWR);
> void *mapped_memory = mmap(NULL, (1024*1024*2), PROT_READ | PROT_WRITE, MAP_SHARED, dax_fd, 0);
> ((char*)mapped_memory)[0] = 1;
> 
> 
> Full details of my test here:
> 
> Step 1) Test that memory onlined in NUMA node works
> 
> [user@host0 ~]# numactl --hardware
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
> node 0 size: 63892 MB
> node 0 free: 59622 MB
> node 1 cpus:
> node 1 size: 129024 MB
> node 1 free: 129024 MB
> node distances:
> node   0   1
>   0:  10  50
>   1:  255  10
> 
> 
> [user@host0 ~]# numactl --preferred=1 memhog 128G
> ... snip ...
> 
> Passes no problem, all memory is accessible and used.
> 
> 
> 
> Next, reconfigure the device to daxdev mode
> 
> 
> [user@host0 ~]# daxctl list
> [
>   {
>     "chardev":"dax0.0",
>     "size":137438953472,
>     "target_node":1,
>     "align":2097152,
>     "mode":"system-ram",
>     "online_memblocks":63,
>     "total_memblocks":63,
>     "movable":true
>   }
> ]
> [user@host0 ~]# daxctl offline-memory dax0.0
> offlined memory for 1 device
> [user@host0 ~]# daxctl reconfigure-device --human --mode=devdax dax0.0
> {
>   "chardev":"dax0.0",
>   "size":"128.00 GiB (137.44 GB)",
>   "target_node":1,
>   "align":2097152,
>   "mode":"devdax"
> }
> reconfigured 1 device
> [user@host0 mapping0]# daxctl list -M -u
> {
>   "chardev":"dax0.0",
>   "size":"128.00 GiB (137.44 GB)",
>   "target_node":1,
>   "align":2097152,
>   "mode":"devdax",
>   "mappings":[
>     {
>       "page_offset":"0",
>       "start":"0x1050000000",
>       "end":"0x304fffffff",
>       "size":"128.00 GiB (137.44 GB)"
>     }
>   ]
> }
> 
> 
> Now map and access the memory via /dev/dax0.0  (test program attached)
> 
> [ 1028.430734] kernel BUG at mm/page_table_check.c:53!

I have never tested DAX with CONFIG_PAGE_TABLE_CHECK=y, so would need to
dig in further here. A quick test passes the unit tests, but the unit
tests don't have this, "map dax after system-ram" scenario. Just for
completenees, does it behave without that debug option enabled?

[..] 
> 
> Test program:
> 
> #include <sys/mman.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <errno.h>
> #include <string.h>
> 
> int main() {
>     // Open the DAX device
>     const char *device_path = "/dev/dax0.0"; // Replace with your DAX device path
>     int dax_fd = open(device_path, O_RDWR);
> 
>     if (dax_fd < 0) {
>         printf("Error: Unable to open DAX device: %s\n", strerror(errno));
>         return 1;
>     }
>     printf("file opened\n");
> 
>     // Memory-map the DAX device
>     size_t size = 1024*1024*2; // 2MB
>     void *mapped_memory = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, dax_fd, 0);
> 
>     if (mapped_memory == MAP_FAILED) {
>         printf("Error: Unable to mmap DAX device: %s\n", strerror(errno));
>         close(dax_fd);
>         return 1;
>     }
>     printf("mmaped\n");
> 
>     ((char*)mapped_memory)[0] = 1;
> 
> /*

i.e. just touching the memory fails, no need to mlock it? This smells
more like the CONFIG_PAGE_TABLE_CHECK machinery is getting confused, but
I would have expected its metadata to be reset by the dax device
reconfiguration.
