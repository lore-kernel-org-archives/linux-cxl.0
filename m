Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDA6C74A5B
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 04:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjC3Egj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 00:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjC3Egi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 00:36:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8075B86
        for <linux-cxl@vger.kernel.org>; Wed, 29 Mar 2023 21:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4wpRra8aD72DwFGNZQe1eRMGNH09POHBFGj0Gh3T9stR3JeogJ0+yRjQJYYKwoI6ze+fT2PwqVS8FZJxA8kcHYWcNsSszDrj5xiPDDRbvnaq6alF0iyB7b7pZmE5w4poijT6ijbL/xvH+NqQjg9jEwQCM+vS+23vb7wQMby3jad6Gw32a9nJbI1xJObriBPtGMpOpXsu3bJOe9YkD82lesGDK1s52J9Y5qA00ZCaTnbUQHkqQkcQQ6Igomm7invAk7RSOcXymPREC3W3YG/kFD0jLs5oDNBjOPtcSHX9Zgiz18xSjsC9SagQXtsuQGZgxso85rfdwqm8XcHpA++mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0dDOiVMN/+x8n/b6WXkt/ZfftTWu6aPGBjRwwqpn94=;
 b=jyD9I02AlCzJ/q07uo8tn+2iKuMuaC3vjf4/5OPjvePju3up6iRXPnmF4ZTlQ2gwQA23SpF38R1ay2G5rBDKaZM3+1jgIYHQA9i8z6j7TWVHShVCwjsz7/woV6FABHd3n2/zBOiK1zuJaIaeERJ8BZlNPZDMYShNjxWMsUP1z2hNw1pP8uvy22wKKJ2qtwa9LKidR9ei2LpjcYRlX00zQEn+htEp33HR6ABXZjPfLF9mXDnsgLVRhWQ4xBWbfxA041WEuCqdX5q/0R8MX5rHmCgpbtSMgmd4NGMiuOdc8ioV1I0BQkl2AKQUAewOSeSQ/bjjv+UifDYdjHCotZcjSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0dDOiVMN/+x8n/b6WXkt/ZfftTWu6aPGBjRwwqpn94=;
 b=PhwQ09B+UEMAM9vNN0Cmdac/ObcDTnWoWSMIdl4zh3XCsi1cB8YsqVbEwGqsWNd6VUNy0YYSI7b34M1F/slQ4gJA8FSgt5qF1TzWv56xK2dvOy0OWM21GeQnu+3A6sH0DVKPukRkxe0AhWT3cSgzLBUMm0Binuob5/gMs/osmnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW3PR17MB4170.namprd17.prod.outlook.com (2603:10b6:303:46::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Thu, 30 Mar
 2023 04:36:34 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6222.033; Thu, 30 Mar 2023
 04:36:34 +0000
Date:   Wed, 29 Mar 2023 13:21:11 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/hdm: Extend DVSEC range register emulation for
 region enumeration
Message-ID: <ZCRzh0VLSVF/7jya@memverge.com>
References: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
 <ZCRhhUDcmypVKu0X@memverge.com>
 <64250e45bea49_c722294c2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64250e45bea49_c722294c2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BYAPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::36) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW3PR17MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 918ec3ef-21e9-4a20-db64-08db30d85757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2poKxRQ9YAATW9y25+H71j7tnma/pS/Ab3pn1J8TTvS1iZMhHtZ1TFmOsd3gBSswngbkf4LXu9ARIac+EA+Dp76n0U01LafmRIifZUCOqvEYkESvz77VWDSzHkXLPNh3OwPJ6hicuF5otcxZmdPNrgSbCNeMh/Q7Xv1Y/eHQOuNZVVKvXFSRXBzQEm/MxUq3M7tTwa/QJkMSfIY8P2ITwHjIEKK+Ka6gGLG90Ga1rgfkF4rcbr+Xypzdca5AqOG0IjD+UqO57OOZl8d7cmRmNCGnpxUhs9nmbOX8sHa3NpNc7ctE0/DGmqfvd/8UQFGr8YGgKucUjnXW6IWuXBXSkJ4mjO2ovbs/7ca1Gpxp1JasmI7VybRBHff1KZOVdR0aovZKkGWIDPDXoajbFFHdt5zWnD3ieqFnTVDivb33N0ptDgn4viXDCxsMTXydr7xlH3zSyJOWaQ+4/JQ5UXr4/SZpbVLTaUUgFmPM1v8rOP/cOGSffAVP8ik8n8nZBfdq4VM6I7eaygUj/1TdpgV5C/XP3zdnXUAgS8xiIguTL4apvrL8a6UiJR2WotoaWhqf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39850400004)(136003)(346002)(376002)(396003)(451199021)(316002)(6666004)(26005)(6512007)(6506007)(6486002)(186003)(83380400001)(6916009)(44832011)(4326008)(4744005)(8936002)(2616005)(66476007)(8676002)(66556008)(66946007)(41300700001)(5660300002)(478600001)(2906002)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F9vS9yXu1E/qsIhPvuXZwqjLW5GMJe7ztGSJZxvv/prrFXH271viqu8AVPzQ?=
 =?us-ascii?Q?y28np7xeTggGRjFdAUjJIsFw7pdONn2ApdAI4bRut4hPt+gIQbikWbth2Zv4?=
 =?us-ascii?Q?5/VkgsiS8xAZOhQaZEVoi6qDbM8ohY9wJ2ZruTqS7LHVH0tsBM2Qe6w46ARC?=
 =?us-ascii?Q?lA5r7R2D9IBqGvYcuxxvjDEQHYKjMtXeGQfIyfG5qhxJRXvWHJ6aPQgEHIYF?=
 =?us-ascii?Q?VdUKsaCwfedFZOk4SJOUDQvZiTZsVzOd1f1t+jcmNnlj6qLp5HneOQTWRQsv?=
 =?us-ascii?Q?ZnbXY4obVTwzJ/VD6Oitwnrm44NbqtoG5LL+2+dxek0IYwtWcUnDLTweZKW5?=
 =?us-ascii?Q?aoRiUDPMs5Ja2RnujX2Kaf8S/22b9VtkKEaLEIHWgN/cd5FM9uXbyMpUVrWu?=
 =?us-ascii?Q?VmeS+nnTDMKxLxbZuvVOpU/ERzmgUsFhc2P8lR+W3g6VPDrIXYafjIUQhoxv?=
 =?us-ascii?Q?qHrxvpEK7lSNc/yhAx9z4ppNZ7KstB70iG3tGSLHXEfMAVIWgS/pNtw1vuI7?=
 =?us-ascii?Q?YbJD69pQsQl9l6ypDsv7Q1lOOljjBEMlHYdvpyWIcRSmaR7olXCQtBM2BV2Z?=
 =?us-ascii?Q?t+owge0KzHEmABo4+cVOvLE+CVSf2ZPrPIrvLKjpJclYGfNug1nCDlCotb8Y?=
 =?us-ascii?Q?X9HhEW1idmscARCsNgEEjLM6EDq6eNaRl3/T9X4jsLy0zh7dVAz9xqao6Nq6?=
 =?us-ascii?Q?UCDaZZpOuQwfweIQ9drZ3FT4ZaLO6cN/DayWI0HZOouAZz/A2rukivKGXafH?=
 =?us-ascii?Q?GNIxNlkEVPd33MQAmiHKrkYUpBXjw2IH2FiQbJfSfllXsvPQuGkhN+iKeMSS?=
 =?us-ascii?Q?4FGimOoiSCninhSqSxA37xZ1Rxo4xzNg1kdpiNHLj9qZFsfZMFWccBTzvq/k?=
 =?us-ascii?Q?3+29VDLB3tuDLrHrjJwgBdzG1pdtTS2ZWbGaEHVzsczx/Z0WSoVAZy2Z2SF3?=
 =?us-ascii?Q?4qsixwCjFFBm21XrIIlziqWqyFb8CwlbOhWoaKexWM6O5/6yd/KcFl3LHCT8?=
 =?us-ascii?Q?Z1z62WB1TWvnXwQTm2VDP5ZbxBxBicqw6w9DW5JpdLD5mcH8Abh7q/KmvQCU?=
 =?us-ascii?Q?Ymwu2/2deyjH7VsVt9w+ozrgseuPrpx/xZxzUERSkh19J4uBYzORJsFeISsh?=
 =?us-ascii?Q?I6/qqlpzHMYSTp5Yrxw7w2dWbhkY6eeAsEmqzXDWXVjMq6qZUZMn5QcdhDCI?=
 =?us-ascii?Q?JfnqFsIVWO0DwLbzsujPUfMAR5O4YcdA70MnLD8WCcdnQ7wttR1l9OUQqtwf?=
 =?us-ascii?Q?qjSWVagNsyeiNLbBoUa/jFC53+KtifpEcA2O5CnyTPWvzGzoAPyeuF3NcCWf?=
 =?us-ascii?Q?fGX+mijrtazkTvMELjhPe/qzU5pjBimWvPa2cbkGYX54qwEpAI46QXpxnks1?=
 =?us-ascii?Q?7kqoorqUVt19x/rGXFjr2+ho+8nN435+q5Lxg+v+4wGFwF0QlKWoy5XymtEC?=
 =?us-ascii?Q?nCGyAZ/GSV1VqpoQHQbSnKxI1tjoj979KTdscWp1F8PHanZxex241IM2KYsy?=
 =?us-ascii?Q?NzJaD4BTiVOnb9QPbcZBbHTdFCLMI0JLxxXAPmFqTv/Fkpu3FxmTu4dKHdcj?=
 =?us-ascii?Q?H1egh7hjZeOC7l/42DkN1W30EgNUpgGYYMepM8J3VXVN6XOhY56N4VuAkEMb?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918ec3ef-21e9-4a20-db64-08db30d85757
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 04:36:34.1317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkfCjeZ8+adE3fFDj5qQk4K5j8XbVxhKg0jVE6vHioH2wwNX70gw8lt+p+9b9JTi30/7/lSleIofwvbJD5Vz4twWALkLRwORxoSvx3lUIO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR17MB4170
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 29, 2023 at 09:21:25PM -0700, Dan Williams wrote:
> > Is the DVSEC Range Register expected to be programmed by bios, and are
> > not being programmed correctly?
> 
> This debug experiment makes me think perhaps the *device* is at fault,
> not the BIOS. Perhaps the device accepts writes to CXL_DVSEC_RANGE_BASE
> to set up the decode as expected, but reads return 0? That's the only
> way that I can see that forcing that offset results in successfully
> talking to memory.
> 

Oh, i meant to add that i tested whether the memory is accessible via
numactl --membind=1 with both memhog and a python prompt, and things
worked just fine.  So memory works.
