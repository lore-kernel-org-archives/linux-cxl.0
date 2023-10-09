Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9F78F62
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDClA/TN"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D744DA3
	for <linux-cxl@vger.kernel.org>; Sun,  8 Oct 2023 20:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696822200; x=1728358200;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=LoOKnY4OXxy8EleGr03/ANEC0GUfZENR4MqI6WEXpv0=;
  b=YDClA/TNPpBXeR2i53LJOUZDuuWNV8ZA4AKLoxpDneo7WVTfk7I/cPLM
   rAP9KK47EC9YBr4VElhl+ciN3TeCixdVXzv/Q3wtNpMa9g6dRkvhQQfbc
   tU2G1854SE2Is4DcHFnDXxE7pTtRDi+hjaV8BtCEKOQtA1GOS6LZ6uMwh
   jnS3k4P0CqFwWyodag7dYyNlNcPQdFYK0uLAjtE+vfmOGxITlL7O9T30u
   FLzjOIV7Gf5jZYldCKt9OjZyihcNPZzFfMeIc24PEnL1x6bwJ0Aas/CVX
   ss8i47Mlm9gbDcB4CLcPlUNyCBAmD6yXcMrupX07MzPRFeblaWEmiKHm5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="374386805"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="374386805"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 20:29:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="1084180104"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="1084180104"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 20:29:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 20:29:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 20:29:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 20:29:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 20:29:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrWKVoNrpNx33ohIIn8pSI5u73zrQ81ECi36U+wAbRBco5L4GirlOwaD0s2fN5ZqaUJne5Y0N/cO4IPTiydYpIP2OayArsn2BIZe76M5MqXC03fcom2X5cxKy6O+zY8LDyL1aQckQQ9KmymQOY9TIDirY3bAyjoCJlzsizwEjr7ZPX6qTA8NpKeMMGpVF4kBFprGCCfv+7XQ0IRGRCTcTAjsiozsIBhO8Xqb2dfsGLFjKEGlbwf7BRRva4J4Pf7xAVDPBqRD8jUxdk1F4xy6vHluat1BceYlTZvkzlWRrPVyaU/bzRUmt4HL0iK/ngoh4bRyMuFzuR1UaZ/6zBpoYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTLi+Gb2uYvWIGwqx1/OHplAV/sk0WWjSl0PrwfQgpI=;
 b=edZGGofyxzNLd4lwWKH1yEXqlAURRlad/xNwHApp08iSlxOuCn8v1ghwnqACen2tdA7BBmrsRJT6vuorUwNWfBb9Y8TaP57vEI/ey+1SKcqUCjVF7NOCydCsY1jyvH6fAnEVq/a2VFi2QuAD2QTsc34IcvlC+Z3GE5iv1DXcam2WobqmBMa97JVg0VjXD2EmCGGpiW8GIX4Dnyea732pwx5PBqFWIPNyVKKoeMBjTEk7dCGoeO0AF3KtBZ9D41GZcKSd29p/E0pLWMthy+Hm8MUHiRw3OaJch5HadHgzyPtuuysfuxiCfkaOjT3JzB+Wa70yskUMa4edjamOCx8QNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB7947.namprd11.prod.outlook.com (2603:10b6:930:7a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 03:29:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 03:29:41 +0000
Date: Sun, 8 Oct 2023 20:29:20 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 03/10] cxl/pci: Remove hardirq handler for
 cxl_request_irq()
Message-ID: <65237390277c3_1d98842949b@iweiny-mobl.notmuch>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657717635.1491153.10040969889268437662.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169657717635.1491153.10040969889268437662.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR11CA0070.namprd11.prod.outlook.com
 (2603:10b6:a03:80::47) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 5230aec4-e9b8-4879-aa6e-08dbc877ede4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wY/wy9ShitvdGOAHBFHjsVv2WfrsRjHGRrIonI1Dh6PimqyS5VLsMwmG2ux4gxui2jt+Bbi7CvkHRFC9cfhSO8w8uBdDgNCGSYpqmcE211YGxcKuKF9maYS4Xpx8KNJDtTlUf9VvB5tmJe9Z0bK1G+1lHKWROQoxpnPITBoMGsRTrRNbWs9Xk7ORvz9u6lhjFHLj8ct0Q60E7DmXX3S1BcjhnoexPqEfiIkm8kQ/BzsBLQ6oTBc/FSq4540I3etq7e5u0HlxcYK2lpOAO7vbU/68lP21/AV/DVbTx0iVnwGJXWOz4AI5pzN11zcjHt8z88+ktc5He1C/Y86U/tb7n1KZhVTaLCpISMlvTvj5+dLyzuylwgV9bRKaeyqEakAy+Orzl8RphQnxktvo9rGjHi+BauNVKkDzaam3HDd9zBaCQNaznp/YA5iEvlFjJQxMdZLooeipoCxmNtNa9AW09CzGnQgo/JLCnh3oZV/15unjMfXY0QCDQ8j8z+lehbIfWI7+CNpF0+1BfCfmx/GXH/XN0k+oZ+S5kzx8FWXW4ZqK2eTOwg/JXe8upK/mtcPF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(26005)(478600001)(6666004)(6506007)(6512007)(8676002)(83380400001)(2906002)(66556008)(66946007)(66476007)(6486002)(44832011)(5660300002)(316002)(41300700001)(8936002)(82960400001)(38100700002)(558084003)(86362001)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NYBjIgEoPCYmcyuSBH4tn5SjWcXAiOSCWVGU4SgEQ7CQlBz/mMEQPxKnVQRA?=
 =?us-ascii?Q?eZoLQXIV5556ESPbD9c0/PBo7UsZL5Wh+Jm7p9ES+s7KmPQXLRIfkMbVmbsT?=
 =?us-ascii?Q?zMKP16BCgb6jSXtNSG8cORZQ1eZLN/AR+nZpt1+n/bnyomjy9RwVL41c64HN?=
 =?us-ascii?Q?vxZ/YOl5BlsaZUyndf5IcCZH7ihByVLKCnG632v8zWA+Dv/cnhhQarXH0Tt6?=
 =?us-ascii?Q?59v53v9EgAxJJNjx1nxaDxna+OIKJCnDig9Z0EWXQx0UM6wI3Sqshl6pz0iD?=
 =?us-ascii?Q?gMuUBHG8PLEcwd/UjCU/MIDQWbr4XGNcTSDfdFYwVDLLex7MPQYEwwUwJQAj?=
 =?us-ascii?Q?8ccuXgbt7Mb/ty/0sSpMejIrVMVa3S4JmMOevUZmZGnWDlqIlszKm+LzZ0VB?=
 =?us-ascii?Q?ak8efXRvGtcRGnwf4W/U5B7IA9LZWlGr9hXOm7I+PAPgKfzkZjq2azTOfjxy?=
 =?us-ascii?Q?YK3e6NORLBnydV5790tK+FXf4IM6xcA5tbYZy1z0xxpVS6IOLEECzlTadJz3?=
 =?us-ascii?Q?BUlRVX5PEFSmvi/7HeGPcvdKMivUvSG6zDXfcrUwrCjIb8Y1fy/0vEycM22h?=
 =?us-ascii?Q?6mbdNtPtynCi4Sh4l0/nYCxxcHOUhaH8Zg8IfoRNbItqSpRcN2imfY3tG8p8?=
 =?us-ascii?Q?7WNs+VbyyuJ/zpfU1OxnYU39hYA31T+VewAFS62ZadTMZSIAw6cBoSHf8PUO?=
 =?us-ascii?Q?HqAr7d52YBqQFanun1hYIWAs2KLg2KaKWyJoCg2LmmeCh2qtyt2NkXRRrC0E?=
 =?us-ascii?Q?uQRin/92Hpukg0lB6GuPYe7SDalBiCv+5vk9YGyxJsegbjbbvMQ8ag1AP2Qa?=
 =?us-ascii?Q?HuFlBjrA8hl8zGbAtbHYy7rk9oZZqel7VNEvD3q0Cmd1XTZ9PUFsATvvTxgM?=
 =?us-ascii?Q?6tWeHtK9zbee1Iuzg0faJiPuNeBK6NG6nCdSRimXB3z5Iir6GTntPzQbVUok?=
 =?us-ascii?Q?tVbqCQh1nuR0cgqSlAPQ9BkY3Nb3K9I6Mz0xOCUtQtvtfL1qWa/pJ6P4p68U?=
 =?us-ascii?Q?NNh1p6UcPcxGchGvkDOSgxR4FDNBVtK02xATeE3I7eUtar3PwjuNm3qrmjSt?=
 =?us-ascii?Q?sdHJxOhulhORJ2E3HBUznhstUF1qsRE2ASGbnVHk51V5NRMqBDsP1krxP9OT?=
 =?us-ascii?Q?adxwl1obfSVHZF+cxOTXLT86FSfFYZSrsoRofoHq8nDx5Z+T+Menq0rkbTeZ?=
 =?us-ascii?Q?VINAqZEnUhNRiXzQ/UtI8M+fzI0WTlfF1UjoOKGYbvS87U/vub1pnPFpNmiN?=
 =?us-ascii?Q?ZzvflikEa6TurilKnjqmeMTThCCnFLzWJqtxZcMkIrlB90ZeFIHAHK/MYI9+?=
 =?us-ascii?Q?hiOu3nvfCo3GnFRHWIIWeQDtZHLnJLmpUKrNEqTKd+oTTGoqimINk4BYDClf?=
 =?us-ascii?Q?3p0Aa+K86/v+xaBNWLDywSZ3ESHrGId7qWImpIYUXo2XKcMNZZeZgxyEbI1a?=
 =?us-ascii?Q?O9JVKhlsuO7SfGtUp9xTJDMDhT4g8xmuzgGWJxnmrqH0rBIo8X7mgjBqDcUT?=
 =?us-ascii?Q?iPbdb4IU1IAJ6lnCkFEdM1RFene5+T4pPIGGlb1MdWfEe9DEa3kpOrS9p6vt?=
 =?us-ascii?Q?0OhSX8h3B3UTVf2fn8Kl9Kz3emPYKSljiw5b1LuA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5230aec4-e9b8-4879-aa6e-08dbc877ede4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 03:29:22.1900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1IOY6L6DscpNLopoJvac+/NUhf2S1JixUIJbx4+NwvIyKUn4ilRp2cXLHdhvG0DVI16f3cVWQj5GjpfGTBeYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7947
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dan Williams wrote:
> Now that all callers of cxl_request_irq() are using threaded irqs, drop
> the hardirq handler option.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
