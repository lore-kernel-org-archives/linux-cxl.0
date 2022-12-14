Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD27C4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Dec 2022 01:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbiLNBWe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Dec 2022 20:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiLNBWd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Dec 2022 20:22:33 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF2F25E9A
        for <linux-cxl@vger.kernel.org>; Tue, 13 Dec 2022 17:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670980952; x=1702516952;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TAgi+PXkjaaof60upfzaUFQBMV8XdDHGN7ST4hEOJOA=;
  b=JzP1KGFwrMX7hC+UyPgUHqkAYth20TKwLBx5OYzkxah4zv+hzdqxnYMB
   mGI+3CTOd3F82WYlCbMAOAzgGyX/ScBTI8dj6RITtj4NV04vipmCoNjDp
   sewosUAHqh0AYcww7JD3M/7vLqLVleV0XOhsFgaXpV0Sw82iRXgI/3P2N
   omYzlPJVRTLnagxYb/ZiU9FUImetda4YwGS9gnGTX36aFb3Vhe0aLN9nI
   VGDlAmBbgjFnptD/IW0UDbPIU090/zbiv3qNQNrp9ZBhXwJ7bHaOspGQF
   1GqaEBLK+Su0/eZebd1klSLeKXT7TldeBDCmoA3LxqYnXdUpVP868H8fM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="319428034"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="319428034"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 17:22:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="642323821"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="642323821"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2022 17:19:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 17:19:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 17:19:54 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 13 Dec 2022 17:19:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+ufVYEovRS6CqaDpMtty1soKsTSxvUuZo0RSwT1/6MVP5OhNLwzs5RPm772bzfpPZ9p5wIeGvYGWh6AMtN/QDphwC4CATqharyoRRqR4akXthX+jD0jvrNI+SSzwqlV17yJ0wLfvXIgBELr/bjQECXeskwXhgkFoaZf8k4YVGwlfPgwqwEN7LX1evhO3EFGPPJWIedyC8Du3HBwokaSznvlIsukSf9LPdzoOsPNbviumoXwXh2Nb3tr107xxAPnhdK3lpN76aAdaYaPFV0U2S8/W3ywSWvVIorKgHq9lWm3QBBQO8njKDDVAAM0e4GzBrc93J79vjTQZKvZZWr62g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IA1xUcpZrySC2fKnhlvwTN8+tdNmK43ZnHzpQWdChU=;
 b=K+4YTz9kBOWvg87qR7vkv4tjmxzojS9EdwFEv9xd9aTV0Bh0cVPAVXRDcgimOLsykxCkwr9+14OWh0gL9BoJZZHrKs9FuhJ4NgaOsKxsYtub4AegdLcwhTE+nWjtoGHg/Eq0Qd7wn9HJzQVjgORhtDTXhIdH8u5Z+hCgghExGkFHaUK+gntcLtyM6HA1knYRNYNkw9Qa60zfU57LQjOZD1mm6AGi5SNdHtrYfNxPHGdQAOZQKT8o2jIDErHNq2ehuYm/wfKUWba0uS29dHzN3uPeYi3/NslQGBSu9YcKOiwXaAyQpmoYLDxMf8JNBt4FpXZCI073Nh0aqldTG3+AJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB4777.namprd11.prod.outlook.com
 (2603:10b6:806:115::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 01:19:52 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 01:19:52 +0000
Date:   Tue, 13 Dec 2022 17:19:49 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH v2] cxl: add RAS status unmasking for CXL
Message-ID: <639924b562293_b05d129428@dwillia2-xfh.jf.intel.com.notmuch>
References: <167096738875.2861540.11815053323626849940.stgit@djiang5-desk3.ch.intel.com>
 <Y5kbiv+YedUYjUhc@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y5kbiv+YedUYjUhc@iweiny-desk3>
X-ClientProxiedBy: BYAPR05CA0068.namprd05.prod.outlook.com
 (2603:10b6:a03:74::45) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA2PR11MB4777:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c70e49b-4c0e-4f19-8de6-08dadd714d16
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cLvV8+oxlsIP/IciMcV2B040y+H9P/kjk2V1NJCmORPs14A4fUNVBXzrvijsnEua7AATv/+fW3hEI/q7puFjCMH93bgVg9edt1vGUahUaQ1BYcfmeHy0ZBA8W86p2uG0J1GvWAQiJg+P0FWBpVg+I/4i5zGwCDhjCautifL+so9VhzBGLmoa6NCoMYcd4LWJVoETS0UfiR/xyP6NwYpXDsP3xeUZuH6Sb6Wv52IyubBw/comCNQxirXlbSBHu02cU6r/7VMTVq9NcqsawBVcHQcjPdh/KNx4LtdMG1m67sGJiOrZ4Hx9KRECle88b7VJNE3VV738EbRE4HbcOXaO/MqyS85P5fqID9xfq3Fcfbw72cQtx0iO3c1xlnpOwRPiPZGnW92cVjLyLu3ZyrDAG0VPIhg99KBrRWYDhoeGr03+6FcJe6zHn4idxtaG2mmVe1fosVwA39QvPJ4cqnWbJtDZHVX3hnL6UvGDbCo4Tgzisty2GvSQoj9qSQ6EZnVTmADFNlLEAHuNtFj99zIEQOpG0A/YTC42fNjqmcVerc4gmUcXHz4MhDFjGO5KHplOHXPND9coSHvPB2vn9ohFA5IniRf/R5VaFG05Eq2zf+02JTaDQp4MyHDoSFdadJz5qmJ9GrMhlIncP6us7dBSZ+nzba//oF8sPGAdRiFcWSC5rXSxE1fBr2JaDVcIgmXZMuQT3KMHOADB63qD8nxpzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199015)(2906002)(186003)(82960400001)(38100700002)(6512007)(86362001)(9686003)(41300700001)(5660300002)(8936002)(316002)(6666004)(110136005)(107886003)(26005)(6636002)(966005)(478600001)(6486002)(8676002)(66556008)(4326008)(66476007)(6506007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9EZpMqNqgm683w341HhISGIPHirAOSrcfX+V5u2HbFTM//MafNFcWU+aNcMn?=
 =?us-ascii?Q?1s4/XUMhBPuz6fVB41pxzEkN9H3BvzKNe/s+3Sp6yBHEz2HznLQALgS1rcJD?=
 =?us-ascii?Q?7m/+5E+G/8jMk7QguWS90Lw0c6zK48ZB7jTGuCIkAAUQQM4vKqBYSwQp5wSD?=
 =?us-ascii?Q?gh2vQGQPG+KOnlHWLEwmwR5+CvAYrnOedrRaF0uQdTIi4Q9GpjSnpj5/slxx?=
 =?us-ascii?Q?pB5loQIT4Sj7RsNDrmaihRViG/7y5eGqTnfVUkONjtSHxNB6PhywcPXsku3c?=
 =?us-ascii?Q?bJujpmlZYmgqi0+Ben7KvQa4V3hvR4ipYxeNFyFfdvJ/XE/L0uE+QLlOPWlb?=
 =?us-ascii?Q?wy5iKePcICEJhZXkPq2tlyoc4jY+NksJSN44030NL1lSUaU8i2c62+/T70JU?=
 =?us-ascii?Q?2ukKmtC7dV/jf/Q7lu7tfpDgTnFRA2E9AGuL6bn5+1jhsivML13/p8wQGnMq?=
 =?us-ascii?Q?V0IT68ZJxuGNucJFyflEtbl0Pcz4LUQtS72UZwSRPI33UTgEktJVIckqEu7q?=
 =?us-ascii?Q?7FhBduPZ5dlw2D87FhYavCjrnZVg0NryptNZ/QiTo6D6wRBOP/AVLHaHwA1c?=
 =?us-ascii?Q?GKY4aJUT/batddfR63r3FiV4LCOVolMGcfXppw/eERRfTFtk7ZaNLD75qgYL?=
 =?us-ascii?Q?2P6tno4BcwXhKb9mxJXEd6fsubsfZlWIUNG3J+AnPGWHG4/qXzm1sZIsPgq4?=
 =?us-ascii?Q?EayxMvuEUq1ZxXGdOYeBIdnLts3yS5HJ2454NrehOJpJH611FOAAVyiyjg29?=
 =?us-ascii?Q?dBuZpmLc2DWu09RCYYOloYe5suMdVLY2HP+mddyGvdSQACr6pmBFc1KDpK4b?=
 =?us-ascii?Q?eexwjyjy+HcAFr5kiiyp97CJMeeK1NNN+09qqxKhsQcUmQdEhNHGRawe04F7?=
 =?us-ascii?Q?cvHmib8u9bxDwwVkYu+6N8H+4KoIlB0V1+WFochEiM0deLeEQqFtKkJq67d8?=
 =?us-ascii?Q?B02fFVQLhgP9t+kkMeiNcFYexosrH02RHQr+GHiwOukJHEEBjbp22/zoDiW+?=
 =?us-ascii?Q?HJ+Tb6vdE/OUHGmJ+V33O1zln3ct3ZrwiVzHPeisOlWZwvfRYTs7D0PZyWvh?=
 =?us-ascii?Q?KyvcXav7aa2N7hUip9PupM9IdGUeRbExYzLp/f75QzpzT0JlbGu32o3Vsled?=
 =?us-ascii?Q?GTnuaNFsueYiUEcs2SseHD0rTJ6qT8PzCLUKZ72q0JxOwSMG2V2bVjlruXi4?=
 =?us-ascii?Q?FWPQqF3jjKi/8PWpV3r9FCWbHKa/8fE31bkbheoQsEXFAhVIimAUgIR0tuqG?=
 =?us-ascii?Q?2wTdWXL606xvcWP+OoCjLOuhoUJhOag1KqbKxoK0rxtYUgdTXR8jQP4RPO+c?=
 =?us-ascii?Q?u8iuzcrd+b0FNMpnhIdJAhGmxjnnSocrib96Co8lJrGraS0TEe2nTyki1dUj?=
 =?us-ascii?Q?K9yc88rj8EUfTk0Efj5kZNS3le4gkW19eJj3ABesxRVXw0Z1g14kTB1in+Mz?=
 =?us-ascii?Q?hKEAVoLUv2YPHNJ9k4WLXkxj6pHIx2J2K9/ckBwRHLz0726ncEColk4szsKF?=
 =?us-ascii?Q?oh0rnpvkFsHTcGeQ1EBuaIY+3FBWhuqf3P+LIZkrAhQQn0rDXXBBxHa0cVPR?=
 =?us-ascii?Q?gXpuVW1V8lPpBQzBSNMq4HOlB9Z+ioIvKLcAQAd6pP24wToLJxiE2Hrg1H7Z?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c70e49b-4c0e-4f19-8de6-08dadd714d16
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 01:19:52.2119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgLIkqTTnATDc3NEZpe17pqzDBrjAL5g+cDrBWb1/IYvbAczeq59Ma16TUdUyeFiESmnhcLQQCEFMQ3bvFfXpp86EfJSKw9SbgRXQG2sSUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4777
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ira Weiny wrote:
> On Tue, Dec 13, 2022 at 02:36:28PM -0700, Jiang, Dave wrote:
> > By default the CXL RAS mask registers bits are defaulted to 1's and
> > suppress all error reporting. If the kernel has negotiated ownership
> > of error handling for CXL then unmask the mask registers by writing 0s.
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Tested with a mod to Qemu here:
> 
> https://lore.kernel.org/linux-cxl/20221213-ira-flexbus-port-v1-1-86afd4f30be6@intel.com/T/#u
> 
> Unless I messed that up:
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> 
> However...
> 
> > 
> > ---
> > 
> > Based on patch posted by Ira [1] to export CXL native error reporting control.
> > 
> > [1]: https://lore.kernel.org/linux-cxl/20221212070627.1372402-2-ira.weiny@intel.com/
> > 
> > v2:
> > - Add definition of PCI_EXP_LNKSTA2_FLIT. (Dan)
> > - Return error for cxl_pci_ras_unmask(). (Dan)
> 
> Why return an error code that is not used?

I suggested this mainly for symmetry with
pci_enable_pcie_error_reporting() so that it is clear that this
unmasking can fail.
