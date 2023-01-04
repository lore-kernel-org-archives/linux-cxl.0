Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4840C4708D
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Jan 2023 03:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbjADDCu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Jan 2023 22:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjADDCt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Jan 2023 22:02:49 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D06BF00D
        for <linux-cxl@vger.kernel.org>; Tue,  3 Jan 2023 19:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672801368; x=1704337368;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k7d7PLT4PHSE2iShRdRk4ApIB4dvJBWuNRx0VBCMmxs=;
  b=D50gW0dkk9uAQTMBildNDb5wR15AjklzATIQcWiTIGpBHd2Ri5TIJ2VP
   m6ZmPHX/a1HLrVL8r1mcUzSFTvdCLZCkh49z7z9qKZtFa4/5OrmunbVUz
   wabQNx9BNvwc2Yww7y6QrAlWEQox5eYwvBOS4Lap6jjMpawfKI8qAjnF+
   eB+LESRaEq5U2EE8O0UFLJQT/egB/7/y4eHVgZ53y4fRdc/qTnlG7s0jD
   t1TLhZ8yue/bwLLTSt9gmugU+yqDOe50St7zj+V6zfqCyhSn/M3dKlJUk
   kkc66xlWGqLPggVBv/oy/J9mTdEQbFvpJibA54CPoepxuVLL0XURD5ZxJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="321886946"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="321886946"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 19:02:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="648427118"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="648427118"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 03 Jan 2023 19:02:47 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 19:02:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 19:02:46 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 19:02:46 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 3 Jan 2023 19:02:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFB5BTevi+NK8VAPw35A18WArSIo72MIxCyzx8g4KHlaez0gSdfiI6ISyX8oW1JbnRsUlTu6OHrYBiBoG4Isnss5kEMEV3hR0ZN3dkFIOuGNLRYbKH2kPrIwRDUZUBPRI2JkxyLDtJCkCxtAVIHHtC5zO0bZzaYt2VazPJjcHGypafcp+occbOOAcuHYSE0KVJDKW4vG3eHZXttMrUOiQBpeUuuvs7l8UxFl3ua3rpWbB177FyhqLq1DNTbK8nAZwDYgeT7/gnLLSIFvmGxjYOGkzzRqyECoO0U6g+ZCnJRzV3WLKqFdc72hpk7jKT2k104suzvlBEsSWdDT1RkobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhJJz/U7HYLq/+3fsJINuN+uRrH7u79pSpWWq4TYJW4=;
 b=HdEubdshjJfG7ZmrFFD3M/YxNBCRrgWz4b1Vpg8eYlqPSnJhWWbZqzSCb+YcGFUFGu7vd61Z+/y7H9t9aKepHt9fugjpnHob7mSGTWr7GUAQ4cCizkC5tBVSkrBcHxQJrtIC8pc5bfpYKR8hUTK2pVEXs9qdUMrYyHxQ/gaBjpqcTwyoLYeriu2/PSXze7rZ1FgElzMKXhWEc/3+0ucgM5yDfo4VCgKSy8kZh7QKqZ4F9XzwsorsBm+QMe9evq1A5R9l/qgSCDyKkuL1JHq2Z2X5RofTNAH8Q5LjwgkAkCUBiJMH6ehMvrQqftLeZaR+FtsOsxsynAUF140ULWaGFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN0PR11MB6086.namprd11.prod.outlook.com
 (2603:10b6:208:3ce::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 03:02:40 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd%5]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 03:02:40 +0000
Date:   Tue, 3 Jan 2023 19:02:38 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH 1/3] cxl/mem: Fix command comment
Message-ID: <63b4ec4e37cc1_5178e2941d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221222-cxl-misc-v1-0-9343bab16e72@intel.com>
 <20221222-cxl-misc-v1-1-9343bab16e72@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221222-cxl-misc-v1-1-9343bab16e72@intel.com>
X-ClientProxiedBy: SJ0PR05CA0156.namprd05.prod.outlook.com
 (2603:10b6:a03:339::11) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MN0PR11MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 18361338-91f5-4107-f02e-08daee00245c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOqA7XaseLfS8pc4wUA7lBJCLAmbiVhOxkpZMwi1tAPoiMWnJdHhbufoiRHnj9u8JJaOUwOKpUyC9b+pfaYnaJijWADHP5sVCjUF3NSfiQ6EDyT3qRDrO+YCsBWjiMIAJ+S2ziuM1vColxo0OD9eGWCju/8rPwhSYWKct28QaDPtTDN0rOAkE5h00TFV10z99Y8+8MJwu2j/jONZs27w7n2GXzTysRy5pSkSEnEYGqilDfSHZyMX5rGdFfpnvsQn6eWsUVcXHlr/WsV4VmpWhZYVY2t0IPGVNHkzZIFAY3fXcbmBjuLfaJ2UQVP0jz7mrgKckU4Nd6IBHQv5RscXWDVohafKmSKAFCmdECvnxxURV9BuR5WHEhhUnewg2D6gDTPgSsgZfL4FmrVdS/Ciw+JC6QVVi7gBcHEfOmvOKuFGQLNujM0VQRPVWMNpmjU/6Cl6kPGaJO1vN9ZGMKE1sy5Lx+oYiaa60IwJhWv6G0FWmjla2FfDxVrHvO0RMMmBnjPHN36wC2APRZF3do/joOr64k9pAwutrj8VvZixRpwY8BrcORpOIohlqZfAknTIyBfIOuIEYFA35mQZkg66A3gWlKW6PVo1z6WLUbRvimPxLkwvxe8uWulivapVKEqf7sfDQWWb1XGTj0H1VuR0Cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199015)(83380400001)(82960400001)(8936002)(2906002)(38100700002)(41300700001)(5660300002)(86362001)(66476007)(6506007)(107886003)(4326008)(316002)(6512007)(186003)(26005)(478600001)(8676002)(9686003)(66556008)(54906003)(110136005)(6486002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c4jDngPIhnlHLH7n49W53ZPhEBv5nM0Upt2Tl0F7O2MS2z3T8DEi2MrFfu0O?=
 =?us-ascii?Q?h5joVAusNnynbddD/e5t0mphXHkR2zRs2IZlI0Ht1N6wDNWRP4lsSLC119i3?=
 =?us-ascii?Q?hh34Nh1yGRoncubiC/g6xwYjYM1PM8xXF4+MaVwHEzaYwp5GLPAFMNnEl6ZV?=
 =?us-ascii?Q?1QTu1LJdG2LDcpea0WMiiX2MmdX/zgpAMKkZMiGUuMRY6NvBkRpqcpCaApcV?=
 =?us-ascii?Q?c54lTKk/Lg3dhX+xehT+1TnubTaoxlcV1oJ+fqNORrey9LIg9x0RERWpK/cT?=
 =?us-ascii?Q?U+2HXyLL2LWEdwp6UhL2W0lC0uJIe1REXPpekxZXnRnX+r5tv5z1GkaFILTl?=
 =?us-ascii?Q?ueC6vHihvFoxFMpTdF1eAJKeFrqVoUloXUhUYFB+cn6yKnLUWjuItHavhUhA?=
 =?us-ascii?Q?5+ZxKES87WGLmlKT8gXwlVcfiSMVyg3jETe/EbzQuL5Z5dUXupCxprN3YI7x?=
 =?us-ascii?Q?4nVpdPdsAgupQkJ3mUJzcYbtlLAncbBi71CIHtPGtELSVSOYcm9JOuZqPiZG?=
 =?us-ascii?Q?jks2Ha6nFjo0qRlTvj2weQeDK7UIWhtvd7dM7xieVRjXJSz10gg6NBgVaNWV?=
 =?us-ascii?Q?X2KN51cx3jcpWjcPGdWJN++sm0EwyxvTPjbM2W5C3eK+GZdSweHPberQ+SYF?=
 =?us-ascii?Q?Rv53wbwzErNPmV3F7dUhi2erxF+nsIWrQfgBUvtXW3nvwSvWSfzY/itYG5bv?=
 =?us-ascii?Q?ku5reoPfozB2SurjoHpbOiUM8ieLLfid+rTFkDnBFmDWzhLD/TzlZJSQPBw9?=
 =?us-ascii?Q?RuUPvHuSEA1NBShZKHb+g+VagqdE4SWlT0X1lXhPoTCf10TIIn0qOyE0uhvV?=
 =?us-ascii?Q?XFuk01bK9D5so1I8ybJz/Wa9nRVPCyM4993sJ1/jfQ9rqK1pwAnOBSgpc7gM?=
 =?us-ascii?Q?T/0biqm3rRP9ko+v5nlUBw49ChPFGXH404g9mx0I8gOYgvvKPHM/+wehQjNB?=
 =?us-ascii?Q?OE3ruY4v3sT5dOeve6z9JAat9htbxamKR+W7TvSbmc4JTA9D7pXWF4rSVcD0?=
 =?us-ascii?Q?5RcvKP3X5cXy3lL4drgjR4X0pQIGRJsbPEi7rjrBZzUdBCqFzyLzjyIC+dtB?=
 =?us-ascii?Q?umnqc4e0TolIl/SLUTUMZ/dbxoErbOU+jj3IhdOddYXOSlfhnjoW/9k8ZAzo?=
 =?us-ascii?Q?6SNLjxxJOkTQj6Exaae3sfNIY3MnrE5hEIhNacobVVB6zOOW7LFGs0JQi6P3?=
 =?us-ascii?Q?XvPeeo4c4f9Qqy9aTxrruKa0Jtkv5q5EdUQRsuYUFlNmWxi5CRKRg5rB0L0f?=
 =?us-ascii?Q?qSHB4wHzreBl5MjfOfFxFc8aiQrSp4iBgoaXXlhYCs+T4+awC4Yj6PqVHvTw?=
 =?us-ascii?Q?gdaOflRDPeFw1PymI3VNcX43LC/kvL2BkzL4lE5WaG2XCw0H3Arsd5LptnF6?=
 =?us-ascii?Q?8MxsUa4Fkecl21zHBvXR6JSebx05nwYXvyENFTf8CalMSptekGTtZQnYFK7U?=
 =?us-ascii?Q?e9Dk7q0ZfrSSXHc2Ywe9NW7wGUeqJbSzV1pO56EIxJieKI5lybdXBkwuX6mW?=
 =?us-ascii?Q?vwGNKP71TQhCq8Fsr3c8tDm2gDfRdjZaQnkTmEgcebiG/+NMmH/HPfmFtL2N?=
 =?us-ascii?Q?i1Z/tDNSOa6gXxAi8dICgnGuomoUEgRCw7SKlGzil3MuE+BZJvTBKcY32eyp?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18361338-91f5-4107-f02e-08daee00245c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 03:02:40.6015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UwNTtgV2LqzfMGuBb8f1xK3QzUrbCZc1M7H4KG4hkom8bmLj+3ATcO29SOrwjL6dPVoYTxA80IM2QLjSCVhCzUrS20woSdGqi2kJYypg40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6086
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ira Weiny wrote:
> The command comment had some minor grammatical errors.
> 
> Fix them.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  include/uapi/linux/cxl_mem.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index c71021a2a9ed..555f9140e2bc 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -11,9 +11,9 @@
>  /**
>   * DOC: UAPI
>   *
> - * Not all of all commands that the driver supports are always available for use
> - * by userspace. Userspace must check the results from the QUERY command in
> - * order to determine the live set of commands.
> + * Not all of the commands that the driver supports are available for use by
> + * userspace at all times.  Userspace must check the results from the QUERY
> + * command in order to determine the live set of commands.
>   */

It's interesting that these grammatical fixups further highlight that
the existing description was a lie. This new wording makes it seem like
QUERY informs about temporarily disabled commands (like those in the
cxlds->exclusive_cmds set), in addition to the device enabled commands
(those in the cxlds->enabled_cmds set).

It turns out this has always been a lie and the cxl tool checks if a
command is supported and enabled by trying to execute it if it exists in
the cxl_query_cmd() payload.

Now we could either go fix that, or change this comment to reflect the
current reality that cxl_command_info.flags is always zero and the
command info array is just telling you if the driver knows how to
attempt the given command.

>  
>  #define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
> 
> -- 
> 2.38.1


