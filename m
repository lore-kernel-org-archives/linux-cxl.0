Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD152C2BB41
	for <linux-cxl@archiver.kernel.org>; Tue, 16 Aug 2022 20:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbiHPUuw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 Aug 2022 16:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237313AbiHPUuu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 Aug 2022 16:50:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F041889926
        for <linux-cxl@vger.kernel.org>; Tue, 16 Aug 2022 13:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660683049; x=1692219049;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KD9lpx9EpwBjPh0muYaJcoGt9Q52YGKKCCrV9y0B6vc=;
  b=Z8MgoLxccEKOFYvtAKWLv9Lc6RhsUpNcVMyk88NCiQBtznHD3INBnqe3
   8YxmdzYxGF8vFbnXfvi5OqCesK8JxwzezAxAD/XEQV1/sKLLAd8+6ZySH
   fpKofF/sWmk5VpyNn/om0+KXlzsrkdGVGe0REUGzMaE95eepVRHWEXycB
   5Nee09XWNefan1YCLJeBAlJNzJt7k6tImMmQZzTrkPaLcG6B//ozePV1f
   SMNPAqafhzL9b0dHSxnKg+5EnMrdcnwAWFqP10Jv2ibvrMXyTYzipvbiB
   EzDzAqnKUmu7+HY0cMtqw9IzW/qFKxjgvcgEsytO2NE2cWLbzrhjW75dY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293601297"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293601297"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 13:50:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="583475280"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 16 Aug 2022 13:50:49 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 13:50:49 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 13:50:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 16 Aug 2022 13:50:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 16 Aug 2022 13:50:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fn2anaHx2X3RS/FXOg0GQcUlwL9YNeXVp7FbM4oprofsuPH7FGBGuxiL/JnZEVXGqkggEZL6SiYiDKKOowYlW3ekrw9j9Jh0heAlU+3f62pncz0yfePLgm1+tMlCGDirkL19hF++LhU6S6QvIrq/Qu2B7H5PLdxQY8I+zm0bBwJZK9Cn13IK9N+TCHeepQSTZk2mVr2OhiK3+7qiXGKcNKCxZtXwRvzKQjJxV9XwA7bHeLPi/79WH1kNGeTyn+573RqWaVF8u9FTlgwSH+Znmv+srnCjwJ2zwXvGM8UpklDBOMtz7mOoZumR40fwUXqHh2C/szHAgmD19QqQE4S5KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxrPCI8l6pLN0Ei8dMGPsE9MfUkp1euRrSXL5WX8bQ4=;
 b=OlkFz+ueI6fO76m4cMMfwl8xqX/OqcNlqsIwDbTI2hcydgoQiyp/3QDRPeWlF7N1bFoUlYpx1dHKcxpEqbxslPuA5LE7cherY3gD1Em5FNoYTQ0IUdQ3Sbk3drSIFTn8gXlGaa6cer8lSn7lhGPVVkooZFXzTxF2FikorKheaJ/d/KgHhRIKdkiVmEdzuKFOo7XTMLyGq97lVXdqjjXiPcS0+t4jM3kK3dH79L/4ryCCgMYwUbMgElkbI9xSFleOGgbRMeFUWelzn+811w/6mlP0XdBxdKaUtjubpf1eQxnHt22EhpifIs6VT5YcYi26El9BzGk8YRYPRFgxPEGPKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB4971.namprd11.prod.outlook.com
 (2603:10b6:806:118::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Tue, 16 Aug
 2022 20:50:46 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 20:50:46 +0000
Date:   Tue, 16 Aug 2022 13:50:44 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>
Subject: RE: [PATCH 1/2] cxl: export interleave address mask as port sysfs
 attribute
Message-ID: <62fc0323f1d91_f2f51294cf@dwillia2-xfh.jf.intel.com.notmuch>
References: <62f5c76060f1f_3ce6829494@dwillia2-xfh.jf.intel.com.notmuch>
 <166067375099.1614719.8244364251253955254.stgit@djiang5-desk4.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <166067375099.1614719.8244364251253955254.stgit@djiang5-desk4.jf.intel.com>
X-ClientProxiedBy: SJ0PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::16) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24620fbd-e070-4990-e2f7-08da7fc8fe49
X-MS-TrafficTypeDiagnostic: SA2PR11MB4971:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1RsnYTP0izaKAolVmFqKnz5P23Dzcof2WRiyrnme8ksdj6TJ/BgcPS58EfoQVXZhl4XCFrtrU95CUrlbgRozGoiX6J5FOCXapr2qX34+uvAgHkqyWUvWF2CHcEYYmQayO6qzZgQfgHDetS6wlgMm5vLWws2Uesf8hyXTXMqzN1P2ftOLhJDa77Tlf+9ysVuRIea8303T+an6UwEd5MGfG43HsYybFJ95efpxGDovizfL/Osu2QJ/SULglYXHhfVDMq78BQNo8JZGLkjxENPxqMtFCiFh1nc3l2GzHC01ojnsoMZslNDBj+nGcQBthTVbPKfEpts5yeSUJoJZSNdImV1cR713cA3agjWKKlguboQj1HIJIdRwd6S2bBPhWIVC1qRIBQq7XwjV4UwrIEU8861RBIcfNYp9+d7S4lhnny5ZsgGELQhlCSVLwQc3pUaZIh0Vl5aVjL0j83jMkEBJZEuppC+Zj4Ewi9Im0VNSdKIuXZ8BRzH1Yum+jnvpL3eouARioZfrmYwbkCGhvyaFl+dj8+GAd3o5+zGqIuTakmfXE6YwdrdQ5zg3JLRdT4oZ6epaL07JgevSZJ17zsbZ50NoYPXfxnvBZWGHlhTJMV3/9a5JhZz5sdGIoMyJFO6c2JmEDx6ETJERPzdVlqOPU2Jze7vWsBA4zs8+zAKJSUOWVzhXlLlmWUUFgXBbGamMaXb8JRm/tJlmanC+3kn7FhompPHt2nvUQNb+T6GoWRo7GodxPDp/VTvF2RnTdJA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(136003)(376002)(366004)(346002)(38100700002)(4326008)(66556008)(66476007)(8676002)(66946007)(82960400001)(86362001)(9686003)(6512007)(26005)(83380400001)(478600001)(6486002)(6506007)(41300700001)(8936002)(316002)(107886003)(186003)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EqXCGCNjxUDaCBd2Asy0ga0t7bnxiE8htjN+XNAsfg1zkfrS4eiApt3Wg5gb?=
 =?us-ascii?Q?hgj+r6g4akrkAKOgrXBtiFbbkkTNYzsegloCYlNxSwWA0csbas9I6qlqfqhx?=
 =?us-ascii?Q?7uMZj8qzWAHQIAtnmaT45R99DA+o2orD9cNMRSJxSBR3Tbg2EWQTPC+5Dv5o?=
 =?us-ascii?Q?gsNA8NHQSa7p8aALuRWguE1IevEr3/06SjHeOHwElNOP4q3RKoGs6r8CzibM?=
 =?us-ascii?Q?EGWAfXUmsJ0Bypzq0xl3Vy0C5B6PBOxjcdH3bwERhuMqO4fddkI0CC7mW0fK?=
 =?us-ascii?Q?lkkt9g8tjaCt0COq3iq9eGa2i1xQx93s0mrrBoKSucYG7gTD2NtHY0jz2ZHK?=
 =?us-ascii?Q?Zde9khoDZfoOUMAvzQ7RiApkUQdSFDQhvKw53RvzEsuSECPECl1x/4udSnv3?=
 =?us-ascii?Q?BHwhgJShsRvTVSNTVD/LP5PvXIhlxERZEx19RXBGzvP8+VaY8aXQqJjua2b+?=
 =?us-ascii?Q?5Yb0dnDHturrVtdgBTbWzAqQN3u3RtZUGYKdkfaCLa2hs7KEu6mG+rX6qKk1?=
 =?us-ascii?Q?omCXdsTMCCIKokGWu2Vix05mWVwudE0AYMt3qyE2ElUy6hMe6Xt+9QxqPtGg?=
 =?us-ascii?Q?+gqHqx/UiRSGL5hNSm89XKjl0/vyaB+OsNu5qT8HzKFIBVtB/cUrm2Is7Lhb?=
 =?us-ascii?Q?oYedd2Jz9D8IDUhrfgKKg8PN6QSSgd2sAfreIXcdpkrOSF9KEN3QyqhbvhQJ?=
 =?us-ascii?Q?c1XEWUvysTRB+JqcZebeWZyry3MNH5rWqHrtiml09i0BErxnb0T0tPQJ25fE?=
 =?us-ascii?Q?FV8b8kOdZIMXt91zZQdT/A4iy4RaDimWLBOBbHUma8uv2iSbu4vO6fOMaFQC?=
 =?us-ascii?Q?mlh4g3gQZ0N1DuyrSMWosj6nZ+lDE8R9JNRwwPH9J/wplgC3BAoctiyC02pZ?=
 =?us-ascii?Q?Cs5Pgz3W6K3YEd0DxRVt9zmlYYmkLgtpmyrDnbZyDZA96TtrOvYoPpgMZkeU?=
 =?us-ascii?Q?8zRmZD+F7RN1bCpv1YeCYg4WsqX6hAEraOwxMOEKhZ5pZJGcbA096VqeT4u1?=
 =?us-ascii?Q?oq2XDIE9gMzuq24oxJy9X/NbS3sfor8dwm1EgYs8fwlCCJmcrjchQ9J5a5Pj?=
 =?us-ascii?Q?Q5PDd6FojJxTVw1G0Lc+ACnKOMRu0t9ZNaqj4mJjthrw6cY07Sy6ueProNfb?=
 =?us-ascii?Q?oZInDJwTRoJb/ROObpJtsvc5tSKxfPCsaY1UHSRjcQVauSPP0ZRx5tlzDuc6?=
 =?us-ascii?Q?H3q7tUkzRpyvz7oLu/CyXKES8wiC55SMbdyxuIVvMLD9kwiHavgozBd/p6Uy?=
 =?us-ascii?Q?rb0Xcbaa4SM40v8IoxDD+vZiGoSEcuaCG2J42aiTHAtfJgAJBbiflC6uLh0Y?=
 =?us-ascii?Q?u547y0G9/hI6iTlF6hnw69LlcbeplwTvdBzKMVgbCLwQryz3/+WMQns3m/+z?=
 =?us-ascii?Q?8GBTm6XijxbkNoVrRZ608YeFIW6Y7XTlDYwhr59vKxLXmxKVMkvRGLq8ZAuN?=
 =?us-ascii?Q?h9XnlWFYYN2La1cC1gR4m15vOw0gB93KszvQrxmeg+QDqp6yw6WBxMF+TMLT?=
 =?us-ascii?Q?bk3d+Pi7ko9nZXilsRlSChHVZKCgfbnwKxnSradHzsyEScedrxPilZdIu1gn?=
 =?us-ascii?Q?XwaioSy++vr8Dj6+WLxatReH/BBh+jd/GmjTH5Gh/w6N2NbCZBnu5lC12xJ/?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24620fbd-e070-4990-e2f7-08da7fc8fe49
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 20:50:46.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vp3XweYNS/cGV/dR8XVf7ggmWR+VZV9QeF1RmpdLcz7JiSmalqksp3ght86GhSyanrp7r0MGHrCvu+fv621y7JgoD+j/KULh9qxnfjDA2aM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4971
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> Export the interleave address mask as a sysfs attribute for a port. The
> interleave address mask is created based off the CXL HDM Decoder Capability
> Register (CXL spec v3 8.2.4.19.1) and sets the bits indicated by th "A11to8
> Interleave Capable" bit and the "A14to12 Interleave Capable" bit. It
> indicates the decoder supports interleaveing based on those address bits.
> The exported sysfs attribute will help user region creation to do more valid
> configuration checking.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/port.c |   22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

This also needs updates to:

Documentation/driver-api/cxl/memory-devices.rst

> 
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 5453771bf330..e3e93e1b663e 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -123,8 +123,30 @@ static struct attribute_group cxl_cdat_attribute_group = {
>  	.is_bin_visible = cxl_port_bin_attr_is_visible,
>  };
>  
> +static ssize_t interleave_mask_show(struct device *dev, struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(dev);
> +
> +	if (!cxlhdm)
> +		return 0;

Given that this is an attribute in 'struct device_driver'.dev_groups it
is guaranteed to only be visible while the device is successfully
attached to its driver. So this check is not necessary.

> +
> +	return sysfs_emit(buf, "%#x\n", cxlhdm->interleave_mask);
> +}
> +static DEVICE_ATTR_RO(interleave_mask);
> +
> +static struct attribute *cxl_port_info_attributes[] = {
> +	&dev_attr_interleave_mask.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group cxl_port_info_attribute_group = {
> +	.attrs = cxl_port_info_attributes,
> +};
> +
>  static const struct attribute_group *cxl_port_attribute_groups[] = {

Lets do a lead in patch to rename this to avoid the confusion with the
static port attributes in the core:

s/cxl_port_attribute_groups/cxl_port_dynamic_attr_groups/
