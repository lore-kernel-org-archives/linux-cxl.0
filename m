Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0A1C38A02
	for <linux-cxl@archiver.kernel.org>; Sat, 29 Oct 2022 00:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJ2AP4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Oct 2022 20:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJ2APq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Oct 2022 20:15:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA4F7C1D7
        for <linux-cxl@vger.kernel.org>; Fri, 28 Oct 2022 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667002543; x=1698538543;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LGpCFEK0/2HMgj8hpBCze6f0w3YZLBp4KA6Sdw3IvZo=;
  b=UVOiJwywsEQaJOAdzhSHGsueHCO9G6Saxtz58ivKcy9hTS0d5GfzM07C
   L5eH+Pc58f+jb0UP9xmHj7yiAzGJeqT31M2g5+5dwu0JC6pGJGI4/649e
   Ek80v4dLV/pYzP19vIIrstoo9jaZjTX8pySwoVq5lxfRfe8Wq1JZi/s7a
   PNkFWw0R8OaLrk9aBtX+B1NBhVxamW37Xbva5TVwuk4VSFgsOCuzoKe/n
   VghzlTvsy2yfj3CQ1axsuB8RoTWRIihFMsjDmRn2MM1+szoY4JNLOfwvO
   eBHTTz6oBMlBBAd9/Yn1UrAaUAzmJih+DaMaQoqgXfohCsk+W394PmVRZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="309708407"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="309708407"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 17:15:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="775560544"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="775560544"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 28 Oct 2022 17:15:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 17:15:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 17:15:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 28 Oct 2022 17:15:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 28 Oct 2022 17:15:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4d6SU1g7dhk9Ke6zdl2HVBFS36Lgic1k36Ik/bRzPuS010mDXNSEmcTYMbAbpj6fFV9oqFdjSgbA1KC6s301qPfEncL5gd9JO/Py34x1BpZqjqCSqzRKPJYB0B3j1FU1uYyqzbkzu9en876r6gh9rmF/sTExvV0bj5DQdZPDwaspB2kS0MbrmF9P13xQpsl79PDtdZULfihmaJ5TpoG5VHS+jUt/aigp2SubAQypEymnNCJ6QCbt3NHEnXyYvrn8Q9Nfg9qoByjsmyI2KljMwjc8FH9NAHi1vtJYoK7qoZsosti3ic1/ktWJYgVYiTjRKsBqWU219dr5R3PHUO8xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLspaE+0GXDwGo4jsaW7iYtTWRlmEyaJWQ3F7xlXdQg=;
 b=iVc6QG5OJroisevjpDz40dOwbA0Ck5WtJi9X/DqrbZ2KugUqPzyh7w/SrtZiOfOPvtvoFiCgkrNEaTd1HTORCQeLyvk85Nu9rTka40HPDn9Y+LsfBeeOHgi+QfDsh+dnZAUlQhIdz5VkUKVwo7+FvAppt29gT39PCnVgJTFfZ+hN4D8YhDcLk3z5dtd2ehwhxrT6SJ3wMnnoDYQY5Nb43612qE1lG60Xe82aLQHUgxT31CXTbypyx2w1qQqKZTKvMXZegla3zQuLXFV7c8ALeJ1Q295DjvNvY9njUAFK284/ajeS3rvMdXyjyhTyXDv+SNrIu1rIqPODoqrPxs/13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DS0PR11MB6472.namprd11.prod.outlook.com
 (2603:10b6:8:c0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Sat, 29 Oct
 2022 00:15:39 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5769.015; Sat, 29 Oct
 2022 00:15:39 +0000
Date:   Fri, 28 Oct 2022 17:15:36 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Fan Ni <fan.ni@samsung.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <d.bueso@samsung.com>,
        Fan Ni <fan.ni@samsung.com>
Subject: RE: [ndctl PATCH] Adding cxl_memdev_get_firmware_version
Message-ID: <635c70a8460b3_6be129497@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20221028235751uscas1p1f5e84bab0e196e19610ec68373e09e4b@uscas1p1.samsung.com>
 <20221028235705.32890-1-fan.ni@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221028235705.32890-1-fan.ni@samsung.com>
X-ClientProxiedBy: BYAPR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:a03:80::14) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DS0PR11MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1d893a-bf5b-42c3-cea7-08dab942b584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IP3CZE9UhNxja9p+TlqRf4T3cQx6AVuYFiWHSlXOwzO6e12rJVrTrB78ql6+yjN94GgCRVIqGoSThG4Ie5L7TO8V8qzmXsVZgQndJLHgVkCeZIYnE2tYV1sTGH/h+K835SzNnv7M3OralW/wknddwVGfJduP6s+YFSV7VfQYMu2SBobMXaQtP2aLAAAGp2Ew9nAvKq65YsoqWdRL9NdfZ1t//xuWb7qiXjFNY0hx9N2WFkDGUi9hbBWx5N4J+uSHz5U3gqVqKgJNHQpGZ4Dl/UZ6UMRkvIPlHdv1w6bw3P0nWKqtIgSyEH6JHtGhCci9OyJMhX+dqoak2yIM3xugMpU2m3FNiHT5hG4dD/u+m6Ug3EoDY05JUGH+7wtZoi+SNittlw/lcSXBL5+6Ox3Ik32ousGeHST16F8DiqXnvfXlrc9yb+il4bng1/K2ElhPIACC1vUb6kHKmEXTkUHykNX0ElKuc9mVMWquy6f8a9cuhtBPGawTlbDpRcqkBsHA+LqB0DC3GvXJeDyE81fr526muRd4ndGApw1zwud+Gn1P54YwUbXWcMuKIof5NfHKsLg1KO3QpdcMD8dyfikT8L+TzuFfVdeYibIjJd7xafnI/VueBW+Z3Pk2lDE3Xkv0brj7ohKuG6nMwpF0UXR+9k3Xz/+9tZ/AeSYYR8AFuJJe9fPe7P/Omh4uNOFm69buup9zxK8mIQtnhOntmhNuog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199015)(83380400001)(82960400001)(5660300002)(2906002)(38100700002)(86362001)(186003)(9686003)(6666004)(26005)(6486002)(478600001)(110136005)(316002)(54906003)(6636002)(41300700001)(66946007)(8676002)(6512007)(4326008)(66476007)(66556008)(6506007)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?11g954UWQZ3i0SicZqTUOAksM1SlTD+cxmOm/wqmQ0Pno2/OtkoCIiS2HyYP?=
 =?us-ascii?Q?/cnbB7Cxy7aiPvBPu/2APoJnorB2K0AZZHsy9FWKt6lUYYs221VnPyVcIRuU?=
 =?us-ascii?Q?MY+btuK3ZIItj53925s4Y28BR/ZTry6iMPkl8Sw1t/ju6yigrA4SSKb8oOMw?=
 =?us-ascii?Q?LQHh6yFNSHPXn2+xz5lIz/MqmmmirF2ixpgO2V7hKioNGwjtAzPEepkSvW2l?=
 =?us-ascii?Q?hRFlgOi+19VjWT0WnVk6IIQGkQLri3WmGSEPAEp6fDIqMNLa/D+dT65NtffN?=
 =?us-ascii?Q?svekYvwb2dCQWQnWHMqkDxkED4cweC8pFHSCZ88joGnpZuZOEw5eNZpszpwE?=
 =?us-ascii?Q?XkJVekQEeFelFz6yqDBjwLjlCoKXCcZ6O8WwzCSSWtOuRn7CKNCzC5CsKzu+?=
 =?us-ascii?Q?Pl28XySbst40Rel1ARX+IyvItUnAK3v1BpCH1tZ4aROmijEHaFrgCv1my/Ck?=
 =?us-ascii?Q?USsjtBXMk3GO+VmntAkc6Y0gs2a3bvbp3xKmWFvCblY2k/8v5nm//86CznIt?=
 =?us-ascii?Q?2R1O/d3k6Tt1DEn++agBfiqM2X8Soy5mgD0KZ8i0GpwA9kMO7Gs1i0IQWHwj?=
 =?us-ascii?Q?CxCTCIMG85W0ddpL7relrBsA/WWKYElyBMxnGUVxsewSBu0ev02Mj2CE+zQJ?=
 =?us-ascii?Q?awvp4YiFvyEe+glCWDXkEf1iMcU/AxKisH5jLT+blXCb6X6rKPk9lhIohCD6?=
 =?us-ascii?Q?ex7c0jCh8awCpKwNSd8yPI6NgA3vfyszHXM/LqGjvaCkgVdu1FC3k4TQqyfv?=
 =?us-ascii?Q?PKEhP+G8/vywmAbOPLgSilp45HPNwf7sQmSD2CjHRvPpDH/9REuN3738tVmf?=
 =?us-ascii?Q?hCSHHFe8jN9A/hYiIcuvfkkO6c2uKbC7va/U0RLCuYnGl+vkeq2Sr/TF+LCa?=
 =?us-ascii?Q?fny3UKg58WRYtJZLhStZvpIiVgAfkAdSYwwEWHHL53bXQYVcxvkBq1w87oI+?=
 =?us-ascii?Q?r/FHtVvbmfTTpfC5Vc9LXMqXa2YIsnLeQs04qdW5m76OGQBHnOOf9pb5ya0L?=
 =?us-ascii?Q?bBlrF2uWNWNce2r3dydO05+t2U04/Xk4R27zN5FD6/Dkge3L+uQ8cITg7wCe?=
 =?us-ascii?Q?JJDNr0TaCJboINQYtImcAfn82cmDfWW2JdPEz/9n/UmnhY1OviSBIVIb4Gig?=
 =?us-ascii?Q?BSXFOLSb7Ed2B4KFG4Qtbpx/2vbH0tEAAuBMD3kEZhueUDITWAqlTWfwxtcX?=
 =?us-ascii?Q?HemSoIao24LeGJyCvl1LhB6Y+lOi7JfX0gwspkseeDVtQCQSMizMm0A2hcwi?=
 =?us-ascii?Q?pB2/gNcUscRhd0mblDRab2yM/9Z8I/rFzAK6xI304QTGSvMiiAZ5UsWNwUh1?=
 =?us-ascii?Q?Za8nCh0ymFIXTigYOseqNMdBlLstABSFLozR635hvMHnn62Qb/hg3sYIJ4GT?=
 =?us-ascii?Q?7i9dMdmvR6luS+qu5WPmpQvuTd4o4DYq/8LyOHy+uaEdwWjFpXHFyJlLWzuR?=
 =?us-ascii?Q?DE8rf9q5df+7plZlf67aBxbW+yhKdLX+9eyCA/FwHa+SUCYE7b1GSNAbJiNp?=
 =?us-ascii?Q?4OVojGyWlwhC7YJYGtaK1ZYRa1GeLenvm1uYX5k7nR5taqzUextQUY4s5TIn?=
 =?us-ascii?Q?lE1KRtCtU5RY2nvb7EUEX26TtbJDCWXdtgqqFyoxBb5cgCUhUV6R4KkxkqWI?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1d893a-bf5b-42c3-cea7-08dab942b584
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2022 00:15:39.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toIiVszQlLBONyRIF5osFdXCPRFIo6m8G0bVD7BqPEKSnWywCNVPEcNf0oojVXtHOgLwMtrp6A1iehiFGdxXmChjHbREbrXluTtyEhoGAYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6472
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fan Ni wrote:
> The function for retrieving firmware version is named
> `cxl_memdev_get_firmware_verison`, updated to
> `cxl_memdev_get_firmware_version'.
> keeping `cxl_memdev_get_firmware_verison` for library compatibility.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  Documentation/cxl/lib/libcxl.txt | 1 +
>  cxl/lib/libcxl.c                 | 5 +++++
>  cxl/lib/libcxl.sym               | 5 +++++
>  cxl/libcxl.h                     | 1 +
>  4 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
> index fd2962a..5a8d980 100644
> --- a/Documentation/cxl/lib/libcxl.txt
> +++ b/Documentation/cxl/lib/libcxl.txt
> @@ -69,6 +69,7 @@ int cxl_memdev_get_minor(struct cxl_memdev *memdev);
>  unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
>  unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
>  const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
> +const char *cxl_memdev_get_firmware_version(struct cxl_memdev *memdev);
>  size_t cxl_memdev_get_label_size(struct cxl_memdev *memdev);
>  int cxl_memdev_nvdimm_bridge_active(struct cxl_memdev *memdev);
>  int cxl_memdev_get_numa_node(struct cxl_memdev *memdev);
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index e8c5d44..1b7e9d2 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -1267,6 +1267,11 @@ CXL_EXPORT const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev
>  	return memdev->firmware_version;
>  }
>  
> +CXL_EXPORT const char *cxl_memdev_get_firmware_version(struct cxl_memdev *memdev)
> +{
> +	return memdev->firmware_version;
> +}
> +

It occurs to me that a new export is not needed for this...

>  static void bus_invalidate(struct cxl_bus *bus)
>  {
>  	struct cxl_ctx *ctx = cxl_bus_get_ctx(bus);
> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> index 8bb91e0..d46c50e 100644
> --- a/cxl/lib/libcxl.sym
> +++ b/cxl/lib/libcxl.sym
> @@ -217,3 +217,8 @@ global:
>  	cxl_decoder_get_max_available_extent;
>  	cxl_decoder_get_region;
>  } LIBCXL_2;
> +
> +LIBCXL_4 {
> +global:
> +	cxl_memdev_get_firmware_version;
> +} LIBCXL_3;
> diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> index 9fe4e99..7951e78 100644
> --- a/cxl/libcxl.h
> +++ b/cxl/libcxl.h
> @@ -48,6 +48,7 @@ struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *memdev);
>  unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
>  unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
>  const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
> +const char *cxl_memdev_get_firmware_version(struct cxl_memdev *memdev);

...just make this the following instead:

/* ABI spelling mistakes are forever */
static inline const char *cxl_memdev_get_firmware_version(struct cxl_memdev *memdev)
{
	return cxl_memdev_get_firmware_verison(memdev);
}
