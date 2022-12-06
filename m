Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C0CC3A5A7
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 06:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbiLFGik (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 01:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLFGii (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 01:38:38 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81B81C130
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 22:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670308717; x=1701844717;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=op/GwOoN6EMB1SfPYh21n7dPfQRf4dn7i4qIwy2V19Q=;
  b=mP99sGlXH8RBWwoHXZERRyw6DujL7q7wYGN+PLw5SiF++NXRn9vnyr0T
   1Hx5v7RTK6dzWUy8THBDl4LItfUVVqGcAgoU4H7vRK4j2Cdw2bxE1EUHg
   W3A/3WhWGovjjNq8WXVK8e1Dki/OoP26LC5KL1WYKDlHDwiUVv2PKMe75
   UPuviakO3fG93Grpg9u1ROL695W1eECuV9BPvBrmtkOPSMGlkCTuT3ki0
   pfsjNCy7lyM8mdxwF3WNbpCBRdL7Y/5sQSPJ4F7tYlJXhBjhAFlQMCB0m
   4NIjRyv8uKtJ5DdgfZOl7zHicRpwOk5W9dmwL8lcr0cbjmhOwLOC7h79E
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="317690766"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="317690766"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 22:38:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="648222068"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="648222068"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2022 22:38:19 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 22:38:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 22:38:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 22:38:19 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 22:38:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqK5p3Zp900MLnABh/LXB7HtONJb/esHNh7jSNfhY++ldYZxZk8Lzu+EuMriFmRu/de/JIa3vwrdK5V2zriS6YhkNFjMr2t0eO52bHOPX6T7dqvzAZFEB/m4QAEzEa7CalUUZdHewHoDYUrWttyCD8gSDq4Uoy8iJfj0BVO/GWSSd43scX1znUXS/+0Pwblwf2UrZZzy7fKUWOYlu5DO9IBXA61pr9KWvDrtACFycoqu6eoxDzlZm9k1+ZI2WuPmm4fNxYXAjDdKMArUJK2zmmwFJWCsjNPiYyGbPssXfXXa/GM5SLbz/pp2acZObAJ3GHpTUSt0G47Z/CGu5N30SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCDwtDbpR0exyua6RdmuNqbe2Bv8QSOL6i17y9e701Q=;
 b=Xm06pnEcv7GfBzRB9suTIG3MU+F3MEFy+XnkjRdSbqn9bnLom3L12MSon6DSo1mxWP/UIxuG13AkTJjCE0dxx15Ux8/1TGcF37Z8kao+IpHDyGvpuARlEyvK2pMSkNUobhuXNr22IFPZK9JH3f2KzQiB9GGzM/2/HA4q1c57dywg1d5HaYlXz21vX7Ev0KGCp6BK1VhI4ybcLetT3Nmh9lHEaW21RBBPJrDBrc4sDu9qJODPEBpm+3KdJReakXCEINHlctV77GQ5VnE/109joP+Ak0oOPc18hagL5PAAbCzkR/JweoZqZ/zAd7V6sgvdIfrBJknGB8ghhOb1Hr2upA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Tue, 6 Dec
 2022 06:38:11 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 06:38:11 +0000
Date:   Mon, 5 Dec 2022 22:38:08 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>
Subject: Re: [PATCH 4/4] cxl/security: Drop security command ioctl uapi
Message-ID: <Y47jUE/1uw0Lmngs@iweiny-desk3>
References: <167030054261.4044561.2164047490200738083.stgit@dwillia2-xfh.jf.intel.com>
 <167030056464.4044561.11486507095384253833.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167030056464.4044561.11486507095384253833.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BY5PR20CA0005.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e344ae5-668b-45e0-9fce-08dad75471e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gddUp/UCn2LoFGKudLFB96gwOPYq5q4g7rm4p5bl/LverTQ1gnYytKf5SS0P94jSN6eGcOz9mCUtZE6x7VHr9GY6mjT9F02PHIosAmJ6ZhwAu9nE8hz2kcKLhlEeSydYzXRgYoETjluhYVUxGiJ/ks0N0hawZT5SHxhjBM3+B438ieoc7093iLP6bQ8aOJXYTLffizVu+pq6gAaCNtYq6xzh8k10frURwh3AeW/UA7/IYHTJL9f+0WiDR3vXs3MXIijM4ojXsKMMyfqN5UrpjTFAiniDX6PxntljJjwRZAPAEs9YRlSCPtK4ukMrHaHFBXkRNLsFw41bXbxC6HDnvCAf40XSfQKiTJY2yJtRm0VK5c0GAYmNajZ73b7V3jaQ+8+kEXKisDBoWCQlZLEelOCiUl6gzV9VjDnc2fl1lBIJDlkSD/JvgUod0mly9pvLe2eXutsxrLyTWzaijDRbW/eusig2fscw+GEL+qE7Z4sHntvzQqXG5xXQT+wnf9jqc2a45pyikmaTNT6nT+/lqSk5k5OCUSm+gyZ1Wn9pAA+xeii5Fm8+evPs77UM+XMIBRtNhMoNagZmVx+/sVVAZISxEeJzsRGnCssuPzvuKTAGxCjqm6oYniSYpis83YqiwMmZ5WR53DraLfG3nAZ5hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199015)(15650500001)(6636002)(316002)(107886003)(2906002)(66556008)(41300700001)(66946007)(6862004)(5660300002)(44832011)(8936002)(66476007)(6486002)(478600001)(8676002)(26005)(4326008)(6666004)(6512007)(9686003)(6506007)(86362001)(83380400001)(186003)(33716001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q22XqpXnBdRpuylUgBte39MHA8oa9x60ynTNMJf3e6y794v/hc5g7WL2/YCG?=
 =?us-ascii?Q?V18fOlKCnbA+lBycNlXic45mQqPOuk/EXwkhk293oZFJC7vpuMJYbUsGJySw?=
 =?us-ascii?Q?Mnzky+sU81drL9WVY2WMxVgx799McvsbtkSC4vdc3y3kVNrjtF59VsfN0kvJ?=
 =?us-ascii?Q?cYgCeEcZ88bXtOBNWY/X2Hcw7ZKLy6C0H7Q0uRCT52eRLI5Z6NhLJyL3A9qA?=
 =?us-ascii?Q?sPjoi1HOyesHJixueFqPIWfQwH4wHStscX+fp8+nfSxYPaXOStLEvGyFB46M?=
 =?us-ascii?Q?Sq2uBiTpUi8E5sLxgPeAjgNSykCBb5ZHBo5dd+zhJaqIF9V6HhvsyAldLCVD?=
 =?us-ascii?Q?flf4t2r6qdv42zFRrh+bsBOsn2pviOo3mhuir48c6LXGaU0XTIy5By5Ootpv?=
 =?us-ascii?Q?sqty+U6xJYCeSfnzHxDjqaFYGZPc6UVzVqylkvN3v6t6DaF/U2atN6uFRrhm?=
 =?us-ascii?Q?ZYYPiJYakX4oyaO70N+8AmXcQBLBE5PB+KWsvvkFNvpnKZvEpNejUC4u+0n/?=
 =?us-ascii?Q?Gn/utSLi+c9bJR4q8TictuQ3sjHnu72/nJjeGHOwwGDfls1VjZfgSP2Z0eej?=
 =?us-ascii?Q?ACoOdZ+HsR56I5CeqTY+0xFXzUbY0RYs1Y8teqtwVufER9W3wQjpgzHYOO9s?=
 =?us-ascii?Q?JVU0hK04I3oChA1+khEldl++0EfCH7D27386odXnfwxjup9BFN9VUgWbGyoK?=
 =?us-ascii?Q?kpUOwBbUAr6nRzOLCpWvFJxKlBoy16vS/LJHYFK80vdVriYPzFSNPK4steoR?=
 =?us-ascii?Q?E/wTcMzLaN/aksiu3JwoUyDsZ3cLh5ExRL+MmF30/dYvOBuuaxJbMrQhQMO/?=
 =?us-ascii?Q?6scmyiHqScgvoGwxkh88G+GBJHd4RTmDr3mvW8sK7zojt1mPXVXNDrUnAVeY?=
 =?us-ascii?Q?8n7bPVSHGoFKnSOtlPx6NzebldrPIDdQp/guy68njlO1jOXedGmppPAlAYF8?=
 =?us-ascii?Q?4s5L/74tnqjuDiLBzbWZiZe3GtkS+7maR79pWeMnWkC/B0gFwGpi6zAAeVdr?=
 =?us-ascii?Q?HxzWU6NV/E8Izk5GcWFmOFwPtOknny+JIdGGUBGu9doaPoDzm8Bam2awM5/g?=
 =?us-ascii?Q?zHLDsaaedbTnUw/Mb/M6XBh9yHwUkgKaaDDApifMvhaYhp9fkAPMLUIoBrXU?=
 =?us-ascii?Q?Mf6GIvX8R0QeX+RqZWnn4QKwPjHsRG9m3yVlEWVl5f0cQdWcBShR4BxCeIys?=
 =?us-ascii?Q?i5RauRIWPxJMY+tinUO86gLgx0BQailnZr40+dHP2rgV35kA4vXF4VYkyLX/?=
 =?us-ascii?Q?ONUURAu7REeyBKfsUdU5ygPCLlGQ8/Us2CbC0demgpprnb3dJA21iG1gN1cQ?=
 =?us-ascii?Q?YUA8cO8gKOo09vMWkvxID+5xx6uit5dlwxdh0nfX4Mvx0xzRaSGpVN/uac6I?=
 =?us-ascii?Q?nLdEAfVOYcEPcvWPXQmRLQtjTGasXZjYecS7qW/Qu6NuLx/DsReUdvGBWFtO?=
 =?us-ascii?Q?YXlio1LdRDyzA2e5gdTiHIKSarG+LyRMgwbgYPVc0+zgy/i1sUmfZH7ADIFW?=
 =?us-ascii?Q?zhhyXyHggDqDR6QfBlB47LlSRSqp81jEGrsHbVTqFX4lue+oKxN8BWO/YaJo?=
 =?us-ascii?Q?ePl7ogQVhnx40NW+3U2RMVn5A7vxzX781uv5pRUG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e344ae5-668b-45e0-9fce-08dad75471e5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 06:38:11.5538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjVqTdJX0ed5pH5wLkYnKb9DbuVx/TIK73NOQLk99tbGND8tZZom8KPB6sYWj4G2pMKt5eN5RhuLCcFJwOL9Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Dec 05, 2022 at 08:22:44PM -0800, Dan Williams wrote:
> CXL PMEM security operations are routed through the NVDIMM sysfs
> interface. For this reason the corresponding commands are marked
> "exclusive" to preclude collisions between the ioctl ABI and the sysfs
> ABI. However, a better way to preclude that collision is to simply
> remove the ioctl ABI (command-id definitions) for those operations.
> 
> Now that cxl_internal_send_cmd() (formerly cxl_mbox_send_cmd()) no
> longer needs to talk the cxl_mem_commands array, all of the uapi
> definitions for the security commands can be dropped.
> 
> These never appeared in a released kernel, so no regression risk.
> 

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/mbox.c      |   17 -----------------
>  include/uapi/linux/cxl_mem.h |    6 ------
>  2 files changed, 23 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index c36a3589377a..b03fba212799 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -65,12 +65,6 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>  	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> -	CXL_CMD(GET_SECURITY_STATE, 0, 0x4, 0),
> -	CXL_CMD(SET_PASSPHRASE, 0x60, 0, 0),
> -	CXL_CMD(DISABLE_PASSPHRASE, 0x40, 0, 0),
> -	CXL_CMD(FREEZE_SECURITY, 0, 0, 0),
> -	CXL_CMD(UNLOCK, 0x20, 0, 0),
> -	CXL_CMD(PASSPHRASE_SECURE_ERASE, 0x40, 0, 0),
>  };
>  
>  /*
> @@ -717,17 +711,6 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>  		/* Found the required CEL */
>  		rc = 0;
>  	}
> -
> -	/*
> -	 * Setup permanently kernel exclusive commands, i.e. the
> -	 * mechanism is driven through sysfs, keyctl, etc...
> -	 */
> -	set_bit(CXL_MEM_COMMAND_ID_SET_PASSPHRASE, cxlds->exclusive_cmds);
> -	set_bit(CXL_MEM_COMMAND_ID_DISABLE_PASSPHRASE, cxlds->exclusive_cmds);
> -	set_bit(CXL_MEM_COMMAND_ID_UNLOCK, cxlds->exclusive_cmds);
> -	set_bit(CXL_MEM_COMMAND_ID_PASSPHRASE_SECURE_ERASE,
> -		cxlds->exclusive_cmds);
> -
>  out:
>  	kvfree(gsl);
>  	return rc;
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 82bdad4ce5de..c71021a2a9ed 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -41,12 +41,6 @@
>  	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
>  	___C(SCAN_MEDIA, "Scan Media"),                                   \
>  	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
> -	___C(GET_SECURITY_STATE, "Get Security State"),			  \
> -	___C(SET_PASSPHRASE, "Set Passphrase"),				  \
> -	___C(DISABLE_PASSPHRASE, "Disable Passphrase"),			  \
> -	___C(FREEZE_SECURITY, "Freeze Security"),			  \
> -	___C(UNLOCK, "Unlock"),						  \
> -	___C(PASSPHRASE_SECURE_ERASE, "Passphrase Secure Erase"),	  \
>  	___C(MAX, "invalid / last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> 
