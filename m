Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39391C5479D
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Jan 2023 17:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjAKRt3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Jan 2023 12:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjAKRtI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Jan 2023 12:49:08 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2751B62D4
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 09:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673459348; x=1704995348;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8gAcFGBXaIrdlKR9JUDCyyj1dRy/nIT2bx4wQDSqXNM=;
  b=WI6RGPAzpAib85URYYO+h0RhuTUFpQ3K3ncpq51dR5DYXvQ2Hb5V/lnj
   0Odm0k8rN6uOiZoQI/a046IROQ1dz072yA4gsk/MMB9fwLgh1tKQszPl9
   CVIH8bE1BqhDU7bNuE+93Fri+S1BqWY5FfS8EDnnsLsiBxnNALDomWewI
   yPWPIRWzQCen+QIHWXt3fsqSUCzxXMtxtII7SkhGMXYYentsWRAlL4ojJ
   hUVZaxRujqYM8VkpYo+8ttog3WJxfUKmZF+tuIYiZP6mZ5gcsDHoV6lqC
   RB37owXPJejWnSpDaJntSW2JfeP/NuqjxrcLIGTDrnmiTf29G17krweBO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303857820"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="303857820"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 09:48:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="720807636"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="720807636"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jan 2023 09:48:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 09:48:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 09:48:31 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 09:48:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2mfQnbFkCAQ4YDc3BqWL+yevaBvBIfw614hFpvZ7k14fOUdZHav+1t4dLs+Yk4Up5wXrRfvaGS009kam/hw0emGbxZVyOO749ZdhCjW3LfqsnAnvWyydEOpRbvjh7WQzWoa8quylHhGWX8dYBBMfX/zJjTTAaw6qyYR3RbokOM3zk72wFilb4KLKrxQxvCEBIz7R7wVtdlWIWJsZciG2t4CTjHat+fqM8Lc7Pdq+7wehkl0Yb/tqeSNecZMjkHch70UyE7JCili1AGTjoZvl/fZjWyFzV0/3g1GdkCnYA2FXhZGKZhyEXUWVYjoMpurwtaac+d0jvLtsTssr4J1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pn3bMntzmUxDDaVYJWmvZx2+iB5jGACiGZVR89Epm/0=;
 b=Tq3dhV9IrsKbX1wCqn1lKJ+Wgfh7lpS2A8E8WBbBBiAwKxo1Kby6nQF/Wpxh7C65dUzqtqVy7bdemSfXOG+DlZnTSY9IUIc3aLFjUZlIBm56cot3A4k1FZnpjZw3LYfa0liyiSGynyYK+O719SddE0/CGbdcRjPR/803oyuKVi2rGzFmlC9txvtIy8i9TE+WkCYZ5torVOYj7PdUkRNjn+KonJKw11454xjvOA4SsaD2E2mlM9oz1TlpUSpGadynBX3xbjYRbn4JWb6zJw91giCB6KR4N+fTWZjSQn4Ovr3vJu7JBPc9CGwDRKYGUsWT3SggExQb3teUBGS+7YC5Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA0PR11MB4559.namprd11.prod.outlook.com (2603:10b6:806:9a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 17:48:30 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%8]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 17:48:30 +0000
Date:   Wed, 11 Jan 2023 09:48:26 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: [PATCH 5/8] hw/i386/acpi: Drop duplicate _UID entry for CXL root
 bridge
Message-ID: <Y772anGNEZQKanMZ@iweiny-desk3>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
 <20230111142440.24771-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230111142440.24771-6-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BYAPR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::48) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA0PR11MB4559:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b227bc-ce53-4271-c076-08daf3fc0cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLKm8eL4e1TtZogsJyu06CHtXmXihZ+YLqKQ9hP22qPrjxOBpFqtqf2x8Db4ZSNJTMnDLEVRTanJqqhKxA3pZRP4wOKUJnBb8AtYydoadLMhdZ3s2KQv6P0hhkaxdzcEsI+EVMw1qE/UeFIzLG3lCKGcFY+hBjkzFJl3YBSF+WaLhTLN/g66iyanXYzDAAHzqqYM8qtaJ7clyG1C/FOq6SawwdDo6hCOClMj+NvTgYZ3qlpiuFsKKbcmj5jpNWsMtRzEdtBUL2X3lYfhSiSl1o3IYL9/D+Tn5KomPn9Sc1bn7J+k+d6FUqbj0q5KB5nXB5EeN8hDgyL12UN8kt19x+AFk6vVZkQLaTQig067+KMYJ5hpFZk62ofJX8jwdbek3txZ0GIIjpviIUAqQH5MY/mBgn1hBpBuBpjUTpMDzO6KZ0+OKXx0+wGt9n/rIOyKRnhDjq1xop9UeJwSy0txcJ/4MoI5rtu1Zln3uq6z+yiuVv2f27+Lmr+JNF+jr68MK4BHPD+t1JU6sACmsCvXU18UKiG0P4fpbYqD9AUce7CIHJIa/kJkKfOtFXC9EE2kEdJmQgaNUQaeJfiVgSyP0dRHrBgz9Q/yeiuLMVI5MKaI5SvUees6kxfgyJ67ZFEEuzsGIN8phhz2YBkogxlCnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199015)(6506007)(38100700002)(82960400001)(6666004)(2906002)(6486002)(478600001)(33716001)(4744005)(26005)(186003)(6512007)(44832011)(5660300002)(9686003)(316002)(83380400001)(8936002)(86362001)(41300700001)(6916009)(8676002)(54906003)(66946007)(66556008)(4326008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lgco4zzcVfsbPQnBziYH6D0eDstluMXKRUjRaCSOC8qTWRRZMnYL4IQ4WeAt?=
 =?us-ascii?Q?SFaaAgqG7dvZvn81IizKDyzNErBFaHdAk3JNeKh9Ey4a/yco3nHFjBFpAQbu?=
 =?us-ascii?Q?oewidN++mIK/HrSartE3yNSBr8B6/Kfg3gk8Bz1f0uAPauI9HlJODy6nhyG1?=
 =?us-ascii?Q?M8BOcWyTOhia/zml8GMrQFsslbBnOf5PCx3fMtI/tHfgyOVuex7n86XrQkOZ?=
 =?us-ascii?Q?1vMkbc3KNubSft8cg3wMZwIe+6UL55XaW3rAwfhXgOQZGswtKUkQVGvAQz7O?=
 =?us-ascii?Q?9tEZVFStkz0tRfAVcWwI2c2XoGIJkSWS+8Wc0n/skj51gO7llaPKw3kPrben?=
 =?us-ascii?Q?8U/V1VPLhhCjKAnWSsNah6hjdsLO47EuepElPpiJj9nzWJqVIWilbl54qh/C?=
 =?us-ascii?Q?KfXWZqTP8QjclbIAmj78ECXcf1FZZrEHU+zmQo3t5/ekNl5b6e4Xo12STmPP?=
 =?us-ascii?Q?auGzSa6DzWgIxv8xduUL7askgC84ArIZziiI6yDwwAT1cTZYLyghTC7WaPh0?=
 =?us-ascii?Q?LMCSKRGVpSM3znQOqFv4/vDzyG3OjzZd7XQL3ST338ocCle9Wzz7sB+e4Rqf?=
 =?us-ascii?Q?SeAMSX4yAyjq7tMXV+2UmAxmy9ezZunFV0TicGsbCHrM2cUEUXrKiYLCUTBh?=
 =?us-ascii?Q?OJ/r2J94THfRdVZkaqZ1ZWJS7XPIcEvGoGNlFDunlbdet0cWgnPESJFwQnNh?=
 =?us-ascii?Q?K0WGDBp8CvSxUVPZxjcMt4R9hA58Z/uQ9pix8UlfAuIEAmdLeYeZxbkPPJbw?=
 =?us-ascii?Q?TLZI+UxMyIw4BmFCBZCnp7QXU6PSjnf9+p8+c+gcJM7ohT3rjUZiHRvZzuM4?=
 =?us-ascii?Q?2F75PvP9MtCHbfJRabPm67GszTTZZIbEXh6QfWbg30RT2NmwBddHeFaQFhFD?=
 =?us-ascii?Q?HF3nX1XVZj4IvfRNslphfuwHLKSICWFescjZtnf7kQW+KjX5xCK5VnQ9CqBA?=
 =?us-ascii?Q?1iB26h9eK6IgxLP4JQ19rXUzFIud5gq52QrKajUqpBWODEqwrkHU9HsxuSk0?=
 =?us-ascii?Q?Ca3zo4t8XwpyYem/VoLEEmLuLkuVuJqma49y53CAdXyoMaxwqUG29d1DtlKy?=
 =?us-ascii?Q?S+Aw1rnu2S7motl5JeJPA7reoxapl/YCZT6gtG4kTd+gQkBlLXfy8BpCc7sI?=
 =?us-ascii?Q?wQR6RNaxR2vlJiZmqJrq/kqLv8E/wnowCPDqhT47h22Boq1EVkqpYmXmql5S?=
 =?us-ascii?Q?v+PN7t+DwC6p+/UumbbXykhgciti5Wz+9p+RNKLurtfIcxU/hF1303o+e4/z?=
 =?us-ascii?Q?zPiQwMFvv/gkmNelUAuhOGwn5/Y8S03Vl8nUOCfwJJ7UWamk4ziImG96uK8r?=
 =?us-ascii?Q?PqKPe5QfpytcF+s/F+FxvGUwEdm+j1oGI7c+1MoHGCnXjM9izjpsMrRFy/n0?=
 =?us-ascii?Q?gmrLkjQrJ2uQqITnLESaqN1am/IuF/osu7ItrvxbmUgbd5AlFEKnDBa88OMw?=
 =?us-ascii?Q?mLOH9SgF2HFizi1kOTtuGmIlcTBzxCNh5QNoLOIjFqGxXMFOZyh1ji/LuDtA?=
 =?us-ascii?Q?Dm43B+07E0GHqarGerjlH8q5TaoJT2IF3eVTEebApjdgwf4q0VcTlrKW95YZ?=
 =?us-ascii?Q?q/0vruPiR159UR8USzbPC4g5eI5gnSVPfByprQNT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b227bc-ce53-4271-c076-08daf3fc0cd1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 17:48:29.9977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0y8edCfJ5B8lW8KVNDWNBIHrYBCqu0d1maleT4ThZ8/CbggQr4vYYMXMqN0dJjy8G5z2JSq9Zp8Ek5jE1BDkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4559
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jan 11, 2023 at 02:24:37PM +0000, Jonathan Cameron wrote:
> Noticed as this prevents iASL disasembling the DSDT table.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  hw/i386/acpi-build.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 127c4e2d50..a584b62ae2 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1482,7 +1482,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                  aml_append(pkg, aml_eisaid("PNP0A03"));
>                  aml_append(dev, aml_name_decl("_CID", pkg));
>                  aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> -                aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
>                  build_cxl_osc_method(dev);
>              } else if (pci_bus_is_express(bus)) {
>                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
> -- 
> 2.37.2
> 
