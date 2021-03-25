Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8E4C433DB
	for <linux-cxl@archiver.kernel.org>; Thu, 25 Mar 2021 16:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FDC061934
	for <linux-cxl@archiver.kernel.org>; Thu, 25 Mar 2021 16:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhCYQt1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 25 Mar 2021 12:49:27 -0400
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:4907
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229547AbhCYQtO (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 25 Mar 2021 12:49:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ew4zY6lEjYnMgDjFP74gEQ4TdiCbq9A5lp+qFLkTLm5X55bAHVQEFENE1ka62iQbc5Jn/UVpKp8iDJf6LKWnzCs7P3Bgp9uL7ZlS6oq8klCsjAUjYM2Yyd0gcRU+J8SUNXzT7eY5LeTCQTgQcuN2+k3rDQZeqs0UABwNPIJqmakM25EUtvCIg6GaoCbupNhQKLS3zW6AKZ0sqecEp5vjl04E+57nea6RWOOIjCnVL3ZVxoxJhNsOxhG1l757++a6ahP+cip/7wgDpoMOOBDlx+1VVPX8aQ626C+FJfWuhH7Y1pG9AUne0n7uiUhKaVV34cKKZVZH4vdlPUF9vMStyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIMNt8KkMoweHN8ipKg4GAGBzYeVR0d4AkgJ+64aYq0=;
 b=eyK+VEnf9OMX35MeXTP9+LEn7pEVbfxB3FBi/hB6nOD+/wyrw+K4HaM/TdLPj7U9/f0vYhbS3xYrz/f85gCcRL5oJqmNK9SZ05rPGEZ8OkxqujdV/itovP8y7LaNpLJSNV2XugrpTgAxedZQhJiZy7fYMzWhynNWbSUUBq2dpMKEWD9xgNCLvwIZ1gIxt79ojWm560JY5mLCk4bbBS3ddUEBmuvrX8umZNKdjtbLSTFResREWtc6txqHG6SR8EFIhiy0YkY3vZVg7zmMVgZcF/fPMbvzcTNNKNijgk76Om9RsHEjLh57MivM68Fq70sG9/BtKpzfr03ydnKJmNBobg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIMNt8KkMoweHN8ipKg4GAGBzYeVR0d4AkgJ+64aYq0=;
 b=RQO2c9cvpxN39lPhJs7Mk8sbLsS/cnf3O5AzdX5YJGVU0P4BI62CsjKnKi9UotX3ui4HDOA+sv55r/pzF3KA6QKmkMDKbtp22e3Hr4bGYvZNjJHS/pxvNffWXFIYmOQVToAlC/ylhnjQEO9OP0FshEai2/hVQdC+ZGdWSgJarFAONmfp7z9f4RWnap4ZBvsbJVM+sMmCHmFMYJHtqAcfLd2y7XbMvxR7Q1EO0E6sJ4CYY67QffOA14S85ipkAwo4EMIL4SBY6aOoqj7h2TdHcjsMav6DwUiJhuekXBBwnmkFh0YFRx+1VquDa9J0Z6B/k76MxZfcbCtFnUElz8a79w==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0106.namprd12.prod.outlook.com (2603:10b6:4:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 16:49:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 16:49:13 +0000
Date:   Thu, 25 Mar 2021 13:49:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] cxl/mem: Use sysfs_emit() for attribute show routines
Message-ID: <20210325164911.GC2356281@nvidia.com>
References: <161661970558.1721612.10441826898835759137.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161661971101.1721612.16412318662284948582.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161661971101.1721612.16412318662284948582.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:610:59::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR03CA0008.namprd03.prod.outlook.com (2603:10b6:610:59::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 16:49:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPTAV-002iiS-94; Thu, 25 Mar 2021 13:49:11 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1710d8a2-a9b9-4c3e-1bfd-08d8efadeaff
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0106:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01066AE50686267D2A796E51C2629@DM5PR1201MB0106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUzaoYmIxp0p9eTxUgAvDASoodepN3fuuLoptV+XsLJQGaTL55BBXytdvHcb6pdEvVOADe1HHoHtCmY39N05jSMF1CaxynaTD+8rCcnS3X50b9sNidfMuZzgkLzn2a6T4fjoKFefyWzklAZjUp+HbcBew9aL0NYeXiLHuF1CQKzsQvxHH8P2+rZZ4QaddoIpjN0yCi+EA6KCCWVY7DEDlcOi/EFzO+tJje8RXbCGn+idkyZrmHX/eMzGyy7cZvj+uAA2gCycAIRygj/AgtTar114vqwYw+rCSzRQJkFSSJOfPOuiLtIj95X75pN5lJezWxFF53edlYUm8ztEMrzIhlN16bi9ILZb4a2j9vi6mCaNe7pPVCXKaIZJHl1m9+tvNyHfSoi1Ix0ip5SSaNEuVti61WVYvtDNtOU9WmTGY61ZIsAKAej5k0Z1+g5tZGGQpx3fq0rEE/u1/M+fkYyP2qM9BAwB6LdfXujxLq5LoR/9Y7LKjJmUdAOoc386OoCdsiY3FF9evcwq4xYV+uU6gVWteyzA/7iskO6Gs+L8T7Undg803oAG5u607o59MaeAspRGAiBuTQdfz+aPYZBDr6ihJrIrQzSo2v5IlU0SNkwQnw5C75OdCBr6NNXW95yJ4eb+4x3I0fxknWY+HgGpORZx2LQjszVyMu9Bc+CZk88=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(66476007)(6916009)(8936002)(2616005)(66946007)(4744005)(33656002)(9746002)(478600001)(9786002)(66556008)(426003)(4326008)(1076003)(83380400001)(38100700001)(86362001)(26005)(2906002)(5660300002)(8676002)(316002)(186003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zIJQoVqR49t4ALhTqfJNqoJlykR+9Np3HM0oUwlVz4D6P67XYysZ3rPphlRw?=
 =?us-ascii?Q?LCeoWBwtkNdM+Kt0Q981asmdT9YQvFLZxZccg42uWmmVoUQ7yrfnGUCtpac5?=
 =?us-ascii?Q?ACWEPohB+nfJg9wD1Yx1sBo4wlNHhSnfaSkk/DB6LCQkiSLFXXBA5ixUINSv?=
 =?us-ascii?Q?GOTLp4eSCF46aFFJgyxpO9LkXlA3jczcZtcq4DHqMhWUjVmonq2wWhy4QF0f?=
 =?us-ascii?Q?QH2+nZMt4Szo87AXDrXhjiAV30trkZ+snqw9lf43llFEq7ZbD4E3Wu+wbude?=
 =?us-ascii?Q?jJrlKGZ83qGHZS2AMHuq74tpqTbTnVIFdvwgRyYcaXiVSzr6S5SYYHV7Tjhw?=
 =?us-ascii?Q?SMJMcjf91hLvEKWaykZ3SVjZZZMuzlgGyTrpr642W5hA+ugjXDNZUYeCwnNt?=
 =?us-ascii?Q?AnFqMG9kelwdSiD5cwawrq3eXExynObGT2WqYwcPu3tYijrj45UV2VHDc1XV?=
 =?us-ascii?Q?mSG4GTjbtusAq2/UAUkNtLHs74rwsYEoHM6rpisxBrWdTtWG9yXamz8h/xvN?=
 =?us-ascii?Q?llD6lwLfLRS41KJYRqau5Crq61uVBUT1CPNIhe7Cw/hARwTmKRVChL5Ehbuv?=
 =?us-ascii?Q?O2Bkl79zrNLjViACIckHaE/utrNCcKvqN4h9p5NkSXPGmTIruDcFw/9JrLBn?=
 =?us-ascii?Q?v+eUuVVONMEE5ib01v+RBWusR8+CcnDxAc6wM2MA9ftXkkoXmj1Ls6LIfGVQ?=
 =?us-ascii?Q?iOAQChYjWJCv1kyiwcI3kH/W1I0EnlLL8a5eNnuIlObLjMdmkzzL0hSh939e?=
 =?us-ascii?Q?lSf0sAvCC06k6BvpoPv5+CHqy9fgqFtPhv03VTs24HuPwX22TqVxtlg+oY0S?=
 =?us-ascii?Q?FIR6XS3mlT0dx4GeORah5xbzP/hkJZIYzto0Z8TBuPPk5mwhalPoXvfTFOMT?=
 =?us-ascii?Q?qzZjhSFspiIwl1LFU4dp4BnuVvWouwAOgRqMO85QRlKEteqFu2rSiyUZYt0a?=
 =?us-ascii?Q?XRV9GR+kCWjJycP96c/YvSrPE9V1Pn+i92tExHB6ECtNZs7G6JtXPAO7AP+Q?=
 =?us-ascii?Q?eESkFdOUF3Vm4dDFg2hH8Ars8A+mCW3LiuXuGbsJp1eb6FmtnfegbppuylhX?=
 =?us-ascii?Q?cJHhgaNh8DCdMJuYr+RixyGfkgx2QWah2WFQL3I0+0EW34l9yPq0OzhuL7mn?=
 =?us-ascii?Q?qrAavaQcJlNaC6nZBwNKBCRkJvr2osktmOzgV6W4MbU8avne+a2B+0i4WXHB?=
 =?us-ascii?Q?UjJv9f36X9obiE75txhmBjbktsw/XS196jmSJ0uBdw0pRVxdu159e4Dh554X?=
 =?us-ascii?Q?JEZniz+fIw3fb7p4T1161kj83AW7hPftocVvrx7zggilmfB8SawzT/K2eg8i?=
 =?us-ascii?Q?m+LYbltn+rE63+t5GnL+kCMG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1710d8a2-a9b9-4c3e-1bfd-08d8efadeaff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 16:49:12.6511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbDKB2evnrZzlg8zFYEHYgUJmVW8JMavxsrK2WtqmcpYfURmh6pKwIsxR6+cbC4V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 24, 2021 at 02:01:51PM -0700, Dan Williams wrote:
> While none the CXL sysfs attributes are threatening to overrun a
> PAGE_SIZE of output, it is good form to use the recommended helpers.
> 
> Fixes: b39cb1052a5c ("cxl/mem: Register CXL memX devices")
> Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/mem.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
