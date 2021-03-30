Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAC1C433E1
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 17:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB169619D1
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 17:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhC3RDk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:03:40 -0400
Received: from mail-eopbgr770049.outbound.protection.outlook.com ([40.107.77.49]:63733
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232250AbhC3RC4 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 30 Mar 2021 13:02:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOLJSUhQp4/MGpzk865LMYt1Q5CHZW0yjZA+NTXOBFnUCnZhLT54BNlcjvkCb4vdX/IyrC0G3vNq6WNvTQa4aEsOGj4nmLeIebSmkEl4w5hwJfwy8v6blfHsrk+GKnLei5eTD2w4YZBp9RExmnHOlCUPq0UpDZf1A2fsXxxjMhiKd10nMixF+F0R9Y35QETuXOBg/PiwOZ+FsxiBZKHxcwvNiinfRVXsg/5yfaFeG7UfvluxP1rCz5XAnjz4iQ0Rg50nD2kmNPK0ce6xAPz1injRYjmHyQIS4MzQfpgxGJT6Fm8cI2emfVUBrs+ItaHc1WK+lswhBlVhnJu4rx4H2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4Ts0oQHR1N6hKJhAV8mgCIvXyOia4GdET1lTYfnyQI=;
 b=Nqt55wlmX15E0Q5TrAX1zFfXCSNU2W2fmFaI4EVkqAJ7v/oSUmieAmwdP18Y9Fj3y0aS0JWPdF74ABn2LMRXtGRxTiAQnt6oiqqyWhe4XzFP8FBzD1QSZB2zEdVamp8LnbkYu65DlsA/nxiQ537wlhIp2pMoRJzX1KVtF5pfpgtnk4IkUpJvUM0OM1FphbP2sTw4X7yD3vL6i1IcrqepIjldjy9NzdwCm5aK8kp7Avj8cPSal8W4yrmd4vkqow6mYf2GCMIe2FjSYQRW0sm9eD+AegRv9R162ung88si6BpVT0E9Gx2m40mayfFQV5MvcY2liZMmx9Br1h4iCCfhdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4Ts0oQHR1N6hKJhAV8mgCIvXyOia4GdET1lTYfnyQI=;
 b=VGvlEfUEak4YpvcCJSzdHPErYVFAjLpDfIjDqb5RHvJGpuvGJyVf+iEZOhfYfirIysJc9YKNdJRZSxUD/lBZ8r1m66q1FR2ylLCQkLorYjUgNzvFtyTJvuidRqrTSepb+4eNhX1lW7R1y6Zrfr51b/uYqR619eVjFMgZZ2sYXe4eAFb4OQo2L2XGobADDeKL7vUmpibxCTqvwYm7WP1NgrtMRsTQ/dxkmfw3Gqw7ueBhfR4DF5TmOM6PkHkfg0bQLocZHzVGrSXW8IRKIFWPH3Hl6L3k3qGQ5aNw/bf0e1D6oK6j8NqAgfcbJ5cCoOTxZrXTmHmW9M2rCQELbGpZOA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3019.namprd12.prod.outlook.com (2603:10b6:5:3d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 17:02:54 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 17:02:54 +0000
Date:   Tue, 30 Mar 2021 14:02:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Subject: Re: [PATCH v2 2/4] cxl/mem: Fix synchronization mechanism for device
 removal vs ioctl operations
Message-ID: <20210330170253.GU2356281@nvidia.com>
References: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161707246948.2072157.2116502455691653472.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210330111620.GK2356281@nvidia.com>
 <CAPcyv4iGByX1+CoUnc3SJahvoT0NGNnbkcDLyEkSJ8YFC9PBUg@mail.gmail.com>
 <20210330154712.GR2356281@nvidia.com>
 <CAPcyv4hL-B=1hostoj9t6EE5impmcDR2-wsgahvBKdzL9LbqLg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hL-B=1hostoj9t6EE5impmcDR2-wsgahvBKdzL9LbqLg@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:208:d4::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR04CA0008.namprd04.prod.outlook.com (2603:10b6:208:d4::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 17:02:54 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRHlV-005xOj-1J; Tue, 30 Mar 2021 14:02:53 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64bdb86b-7957-4d12-f611-08d8f39da8f9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3019:
X-Microsoft-Antispam-PRVS: <DM6PR12MB30194C452E1780C9E80FB863C27D9@DM6PR12MB3019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZjLBelX7Cjo1vAO3Dd5wLXxzpSm8l2PI4BBHEsz1KFDR66V5CTCoYHfn2LJei9dr2Cn34JllfCtIybiCc2KRe8axBa+M5CmVFUu3QIAYCc7EkiG/eXIj9u4hy9WlrBqlIfP5CsTUfAaw4OSWZiXGC09kAmc9i/Dmt7iEGZJMhbkf0IIoXc3TGukC5kowPLhaErn+W4VMICAHKZ2CDB8IV8u89RCkif5ASeKTPs497ePcI9d4kyipGEohTYAVCSLaFzSwQEOlPdi04zK5MFHgIBKsxrdSEuLsCBonmVAb78IsmPsskX5fks1YyLeRiHnxuL7t12L+vZpYTNMYXdSXZeGjruKhGH8Dd/I+HgxY3iSwCSiDRxDwyXRyERx9T/hsZplATWa4Yz0kVzaTBxMiu9dNuLxhlvbBnsmbr4pC7XYECfuV5SrMwVKHoywrQu8dWWWDVSSP7JCvvrbYqXvhf559sd4SxjOGCKA+ZAculHXFfQjC2bUP/MsRSLvto4MowoYCu1VEA2KSCrWsyxLBA4tDx2G6uPHv+cCB0OLEBXtJIeCk7bnQ0tPW9B0PV4jGblMYsMdwUo4RgwGJxzVgaxkix78LbHyJpj60gTPZn2ZBlOmu5Fy2Wf6eA7doiSKy0q/VscTph9KYY0K1VZj2LNuMK162yXWmwpfbUgoNzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(316002)(66556008)(66476007)(66946007)(1076003)(426003)(2906002)(2616005)(54906003)(4744005)(8936002)(4326008)(9786002)(86362001)(36756003)(38100700001)(6916009)(186003)(83380400001)(8676002)(26005)(33656002)(5660300002)(478600001)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TCnONsnE9V2FUyBQGS9lI/X+XDfruRqdeYhLgcjZLqEMJ+b614RTzfcHNdHK?=
 =?us-ascii?Q?g7v97MJiRIOeYOnlLhhmeAF8SJ2w0ifAh/W9n04k4bfPOlBshbbnBNt1z8F7?=
 =?us-ascii?Q?Ucsk4V15EgAX0hsir3K25IKjQUSJg9hs1rxBeUIxTCLglo4lx+d/RlNrkg2d?=
 =?us-ascii?Q?vl5Pd57rlbfb5ySVNDbq1qZDyaOGYOG8nSI2GVIU/JaOPl/0uZVWObPcz00j?=
 =?us-ascii?Q?wGNcIQct3kbp4/bc5xQbZRdzSVl/4JNxjSQCWLQb0gwsYC63D6V+VcTWYN3t?=
 =?us-ascii?Q?B2KGgMbgWd/ITrjoOUE5KWCHt6U3JuMBg7oadyYp66teEkLE/T4GqQTAOCec?=
 =?us-ascii?Q?8CiPF2mfGwrOqXn1zbG25iWYTSpUsH2cJZUJEREqwH9zv7XrRn56xEYvJCI+?=
 =?us-ascii?Q?X8Or+Vpf2EM4f+HBjUXsqYDJgJIW3dYguwQoeNaO33l48utlUKjJHhwOOGLi?=
 =?us-ascii?Q?qMNuPFDIzMbep8JWKBFqLyqj0Ki37+CFPUK55TDyENSrDs5lChBV5e6INNc1?=
 =?us-ascii?Q?fOB527SXVKFg4CdjgJp4OXwueOMtifHNe17AWMl4Dx1y7dLLIuStYldPZhMx?=
 =?us-ascii?Q?ZA/9cyzxUI8KbYJIs9QcJqkV3n4M0p3ThlrUGdwO+9P+l/XO1C4Yq+Z5WnaM?=
 =?us-ascii?Q?sd6tBUTgrDtCuhQOTThX9/YeIWd5JMQDyjlDe31O0JLskf2+c2nQPV3tQ+aH?=
 =?us-ascii?Q?ZVD5TyWAxFyWFqEqs9GkoB6T+uSnWDPVfjuroUxdJPUikc0ngvQAteSAfu4N?=
 =?us-ascii?Q?oXGYs4G7/MGcsmrUzTnY4nOUkOYUJABRkGaKo+OmJZKd3p1uir6A+xlaEeAG?=
 =?us-ascii?Q?Bz7Upd1OJd24krM0Ngvyum+mQAh/MOBo7QpJf32xEKqaVX8MLens4wAL1okO?=
 =?us-ascii?Q?uyWHpEcoYEr2QqAIjet4PAfM3+D2L217VmaVdOKtba4Z2Uq074nEjnJMdpsl?=
 =?us-ascii?Q?joAn7+HjAkfl5JXtK2nSBApe30pddnpHIKQtqaglkMbcjK87WIjaMPx8rjnX?=
 =?us-ascii?Q?fnqBEP7qCub1jIxqEA41CpH7+L0/TlYL8OoUgkxfJGjzMAhX98Tt5pU10w44?=
 =?us-ascii?Q?DXNnYYmMmRmzUSqLe6RJNnCuM1n7X6mtJX7bAoskQOBxPWOTUqTqbTdL2rpf?=
 =?us-ascii?Q?jhleka+Qazm+uqq+eNDuoqEvZ6sLQ4TJNAnD8Odt/oUrNV/uxEa7+pHlYDuS?=
 =?us-ascii?Q?BTKz3KymxhVBKXgU3AzNh4LeWVroj0icRmGf++Z8g4JrRC0aAkrGeNf4KvtY?=
 =?us-ascii?Q?m4oVla6BL0Cq3w4DG88e4PCX9Orgv99v+hpejaZM8BV62S4yTQiOW3OCWgWJ?=
 =?us-ascii?Q?9flI0029/0Bn60dF3Uzovv7GbLlT0Aj2iqLa+V0ohNlfqw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bdb86b-7957-4d12-f611-08d8f39da8f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 17:02:54.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFZSKybsaftvk49EMQfkEfyWFZGn2LMSQ70rXiNGLVfewiABwYFogH/7WXt82yli
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3019
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 30, 2021 at 09:05:29AM -0700, Dan Williams wrote:

> > If you can't clearly point to the *data* under RCU protection it is
> > being used wrong.
> 
> Agree.
> 
> The data being protected is the value of
> dev->kobj.state_in_sysfs. The

So where is that read under:

+	idx = srcu_read_lock(&cxl_memdev_srcu);
+	rc = __cxl_memdev_ioctl(cxlmd, cmd, arg);
+	srcu_read_unlock(&cxl_memdev_srcu, idx);

?

It can't read the RCU protected data outside the RCU critical region,
and it can't read/write RCU protected data without using the helper
macros which insert the required barriers.

IMHO this can't use 'dev->kobj.state_in_sysfs' as the RCU protected data.

Jason
