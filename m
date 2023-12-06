Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="bULd8Fgz"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D96D6D
	for <linux-cxl@vger.kernel.org>; Wed,  6 Dec 2023 09:02:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kutc/XIFfKfAgeTy6G9qCY1YFcNPg+XZAooi1Di5fljytf11I5mzFBKa2tIQIlrK6w8sW3mLcOzYtsJYoqRZYmiYiOqhKDIXmbERpanqwFfX2/IDZX7sM0L63M2UbFZ7Gst6MTSgrbKa6wz81taX+RwpjHs3c5gCBBVi01ekDidYjwdBbzmIE225duBIndJkbjhmMcoQO5CRg4CBPTbRNGAMnXqFOhAfO0qyIERUYsQVg2Y3aToX2UDCG5h4KXwjdhMd2zfRAB67w/NmaAxIg601lUdZJ9v6kbuwIV2G7sn0huCJKl56QpLkYVoqqQhgq8JgrszMSdCu02L94of3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3zyQGFfVCHrMjRiCGzlR8g7BQM9rIiIg4mKK/kWWRo=;
 b=ZeeGv8Q/7ujvNNLEq4C/8CTAvs/DzTLqIRWY3X8+K0yCyWfctF9W6ZWoDJDEFwcx3YWBpxu47CVyJG7JaEnVpmNFJ7ijxA/osNez6mWZ/31BMPIJS5nnJIPbLJzlDQPa7VfXJq+bFOVdHUccVuN7w/VMHPh8331Kx35bw67l7j/+wzezYpfn+7UVqcVwf0/CQCdaGOd+qtzRbGAcwZftbm5S5XLY6OF+G63C+4iNIt+juLR997Rx9odu70ZCdm/VaKpKWuCij9NOsfGiqJxdl4VeYu0QinKe/OYUYmXqWc1ezQMUnOfWBMse/fhCkghAnb6gpQ0jrJPKT/pnL5p3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3zyQGFfVCHrMjRiCGzlR8g7BQM9rIiIg4mKK/kWWRo=;
 b=bULd8Fgzsj1rcb3BOToT1YN8MOMWswY/mkD5XnV4OKyeDodgnSTZoUmYKCQXjw4w4HHQm7sPgU+W2byuHOK75H2Ar0Xpz6dLgIMuI75VYrEc8rGCgvqsgkFsa/b+sDn/I46QkI5AvIuxiKYaWrg2cLBnH74kDw3dtYz1J+K4oi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CH2PR17MB3783.namprd17.prod.outlook.com (2603:10b6:610:88::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 17:02:49 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 17:02:49 +0000
Date: Wed, 6 Dec 2023 12:02:45 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Seungjun Ha <seungjun.ha@samsung.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	KyungSan Kim <ks0204.kim@samsung.com>,
	Wonjae Lee <wj28.lee@samsung.com>
Subject: Re: [RFC PATCH v2 4/4] mm/mempolicy: implement a weighted-interleave
Message-ID: <ZXCpNfTQN7ziFrZY@memverge.com>
References: <CGME20231206080944epcms2p76ebb230b9f4595f5cfcd2531d67ab3ce@epcms2p7>
 <20231206080944epcms2p76ebb230b9f4595f5cfcd2531d67ab3ce@epcms2p7>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231206080944epcms2p76ebb230b9f4595f5cfcd2531d67ab3ce@epcms2p7>
X-ClientProxiedBy: SJ0PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::34) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CH2PR17MB3783:EE_
X-MS-Office365-Filtering-Correlation-Id: a3588fa4-f78b-42c6-1174-08dbf67d2d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y6PKROAJ2081Trngho5Ggc5XORxBuHxYF5RQENkCJeRPII1if6cGJ0mm6shhWuIcxevgSTb/pIHXx0gBhjrF3OFD44f5ZoLWg+SuNkvZj+gOu3Fw4mGRHUD0+1SKChHBwglvJOovuIHPQFweuXQh+1A4xUtqla0WcBpGVAfsPwRQ4TXAnrGZS5nRelNC6i0iabYK3QXBr5VN8NIoQxV5Yv2xBnK3RM5fBvGM2bhYRMAyd36iogetug/KA7Dwm8l+YnVi8Z+2Aph1CvsqzN4ZXm1YFHFGLYf/AHqIz8m2ENQiwUJdv3qqKlJFWbvEesS4sC26I7r2tKrITu3KGB8DP0RNY+HVI8xNwnEX8d7S2Xk5soqDwzuuKTcmmP/J7SGYY2oUZ00KYYR3NS/Di3+C7VILrG8juCjnqfxvRLH2mcha7TwlcgKEUTjzppHi7z8h2IXgMts7C0td5f2OkkktwIXKioD4LCIbplUHIp5KGgQPPQCCgA1Bg5VQs7t1Len8frT9pAFfI6vo5wJSI8nuY6FERya0slBUspnhdEHZ0h/TzalkwSg5Irx1PUjSprBcqtdkf7MOU4K4q7pi1fh342hooSLMqzM/HgcI+sEQWxE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39840400004)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6512007)(26005)(2616005)(478600001)(6666004)(6506007)(2906002)(83380400001)(5660300002)(44832011)(41300700001)(66946007)(6486002)(8936002)(66556008)(8676002)(316002)(66476007)(6916009)(54906003)(4326008)(38100700002)(86362001)(36756003)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?1b+2Nt4COo90fGER9lesmTl0W3DTbs2cz7xGSyx6BAEFoUaj0ObtNbHkPF?=
 =?iso-8859-1?Q?wLBFtsUWb7PHCJQh1ibgqnrS0dQ1mYFKxyyYk4jrlO13gVqkzk858Q1Iqs?=
 =?iso-8859-1?Q?X+W1nDv5/MZcG58/x5SM12mmftrSIIYObvyf+ly4g35DnsvlcfnXR6ySmb?=
 =?iso-8859-1?Q?QeDWkPeKOykzZpL262zvN62L6oSzKpNtmM1oghM7IOX78qdydqXpCYFWGD?=
 =?iso-8859-1?Q?wqXb1Yv3oLy1XE6aEzFBrx1EFvL54Rz0bx/8EB3tyf8+ZGKzaqxWg+XnFP?=
 =?iso-8859-1?Q?aT8JhhBSdf+UziQhQP1qTfzs2+BiGaiW5BpgnGREqsh8cdBmkFSXwGel8D?=
 =?iso-8859-1?Q?nGurN/eC28Rv1aSvqUeC4faMtP6PZNqSCPgirkyjI9eimFvU6DuKf2lPZu?=
 =?iso-8859-1?Q?DdlxEI5kJ/C9i95eym0VkohJg+g9xYoYWYXOMtWsAfu4D/DgT2Pb4A+JHn?=
 =?iso-8859-1?Q?T8VXVZtYBnGeWK6iNUj30lfHwN1eieDF0LjPuuCunygWnOMeyyz2Ad0hds?=
 =?iso-8859-1?Q?pTUMmL2ykDCwmBavwkoKe+fkL4/bv6dBo+XmDJK++TieIzb1SOsa/Sbrqy?=
 =?iso-8859-1?Q?4N76A2uzhwZcYjhZBAGSwPWCEA54GPFwqkkL8ulyo+KCMgn+bhzbDUy2Co?=
 =?iso-8859-1?Q?u8qiQB4aELmiqIwiTZopa+PHjCi+yZX+JjimtSTN/BknSiO73GtkZv9EEC?=
 =?iso-8859-1?Q?RKxf+bnhP4PPP9gtGE6XxWFnBJsCTg2mKTityhcRB1qsizV4usrr02LXd9?=
 =?iso-8859-1?Q?flomxYCg+3mOIIaE9aN+siayo8Fjeb6Cz8gxyKoECO89DDGv/EtW9OoIz+?=
 =?iso-8859-1?Q?SMYZId9PFzVCEd1ENm6BLgvLruVIle+U3Lr+Cxtb8B2DFlSdMmZg3BYbBn?=
 =?iso-8859-1?Q?2VL919lSl3tMLsyhQWFHpEWXQXyKzhnvT8D+byyumk1HeTn4sEYl54Z0be?=
 =?iso-8859-1?Q?wCJHc5tYGEwArryMtw8ETwxU72YoAIeS3uOvzgAHJOyI1qo+5RLmrXKwZJ?=
 =?iso-8859-1?Q?LgcDkEopRJ7amoDgmVVEw/tnlfh0GNZ4f1J/GCiDHtZH1LxFtqgxb7HjkK?=
 =?iso-8859-1?Q?JXCUJhwgj1iYzUoFQBvwlZG3UWSbyyA/HBlkObpEkLm+kFY9Yk6r5k5xCt?=
 =?iso-8859-1?Q?FkS379/By68xWtYfwRyUewuV6yHMRYbxr4PLAWVgY+qCUk4CxyfYlb5mYD?=
 =?iso-8859-1?Q?IR8p+USwLO2o/wrEt0LMsSxrxILPDS2+Zzh7lf50/ATj06CWlglFVkERRM?=
 =?iso-8859-1?Q?gZnazA63x5NndYpwBNtjNR4uhaW/3BZ6R2utbRfjhxiPjeUD8tdha+yW+y?=
 =?iso-8859-1?Q?fNblIaM5gWVcm7NoUTpI/9D7ADdOFlEk5to3zpcaDvLA+bZdOf1ZhS8epj?=
 =?iso-8859-1?Q?KD/hx8Bvyr/oajyZltkgwV4J0t0FJCcjtIj+kiJZmvCU7/yCRSSTfXBgCI?=
 =?iso-8859-1?Q?5f01z2qQoYJa7GrcdOhi4wA6osBoLDHyX7AN8z9smMLFjbBQHY2kEilmB2?=
 =?iso-8859-1?Q?TZi7G0NK0pyuhvUP0ByTxfkZ4B4W3e8EOUNPC4uRMACtWldZOjtABaAlfr?=
 =?iso-8859-1?Q?cz4Ovr2cBbCIZDBaUL3QknaZX27G226DmUWWqDkQR1jFYE2Wr6q2oglCaQ?=
 =?iso-8859-1?Q?5W4J5uHoxDCes+i/FxDZjfuTR6RbNR35YGwEmGV+h8Zr/bCJdh4EJ1dQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3588fa4-f78b-42c6-1174-08dbf67d2d16
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 17:02:49.2218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Iv3OCj4wIAYGQ9eh5wr+hoTLVsJCLnLCExzZgg8XSjl180yye3RV8rGZu518dfIW6e+K/irF3TLPuFB1I7a7gdkXNlElSrBp4xtWIesVCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR17MB3783

On Wed, Dec 06, 2023 at 05:09:44PM +0900, Seungjun Ha wrote:
> > The weighted-interleave mempolicy implements weights per-node
> > which are used to distribute memory while interleaving.
> >
> > For example:
> >    nodes: 0,1,2
> >    weights: 5,3,2
> >
> > Over 10 consecutive allocations, the following nodes will be selected:
> > [0,0,0,0,0,1,1,1,2,2]
> >
> > In this example there is a 50%/30%/20% distribution of memory across
> > the enabled nodes.
> >
> > If a node is enabled, the minimum weight is expected to be 0. If an
> > enabled node ends up with a weight of 0 (as can happen if weights
> > are being recalculated due to a cgroup mask update), a minimum
> > of 1 is applied during the interleave mechanism.
> 
> I found an issue while using the RFCv2, and want to report it. 

first, thank you very much for testing! I'll run this on my latest fork.

> In my testbed, calling set_mempolicy2() causes pthread_create() failure or system hang, depending on weight combinations.
> 

I think this is likely because i did not handle __mpol_dup correctly.
The newer fork changes the way weights are stored, so this should not
but an issue, but I will use your test to validate this.

New RFC should hopefully be out this or next week.

> FYI please find my testbed where there are 3 memory-nodes. 
> 
>             Node 0  Node 1  Node 2  Result
> Weights  
>             6 >=    1       1       pthread_create error: 11(Cannot allocate memory)
>             1~5     1       1       Pass
>             1       8 >=    1       pthread_create error: 11(Cannot allocate memory)
>             1       1~7     1       Pass
>             1       1       8 >=    pthread_create error: 11(Cannot allocate memory)
>             1       1       1~7     Pass
> 
>             6       7       7       pthread_create error: 11(Cannot allocate memory)
>             5       8       7       Pass
>             5       7       8       Pass
> 
>             40      30      20      Kernel Hang
> 
> 
> Below is the test code to reproduce the issue.
> 
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <numa.h>
> #include <errno.h>
> #include <numaif.h>
> #include <unistd.h>
> #include <pthread.h>
> 
> #define MPOL_WEIGHTED_INTERLEAVE MPOL_DEFAULT + 8
> #define SET_MEMPOLICY2(a, b) syscall(454, a, b)
> 
> struct mempolicy_args { on this RFC... }
> 
> struct mempolicy_args wil_args;
> struct bitmask *wil_nodes;
> unsigned char *weights;
> int total_nodes = -1;
> pthread_t tid;
> 
> void set_mempolicy_call()
> {
>         weights = (unsigned char *)calloc(total_nodes, sizeof(unsigned char));
>         wil_nodes = numa_allocate_nodemask();
> 
>         numa_bitmask_setbit(wil_nodes, 0); weights[0] = 40;
>         numa_bitmask_setbit(wil_nodes, 1); weights[1] = 30;
>         numa_bitmask_setbit(wil_nodes, 2); weights[2] = 20;
> 
>         wil_args.maxnode = total_nodes + 1;
>         wil_args.wil.weights = weights;
>         wil_args.nodemask = wil_nodes->maskp;
>         wil_args.mode = MPOL_WEIGHTED_INTERLEAVE;
>         wil_args.flags = 0;
> 
>         int ret = SET_MEMPOLICY2(&wil_args, sizeof(wil_args));
>         fprintf(stderr, "set_mempolicy2 result: %d(%s)\n", ret, strerror(errno));
> }
> 
> 
> int main()
> {
>         total_nodes = numa_max_node() + 1;
> 
>         set_mempolicy_call();
>         pthread_create(&tid, NULL, func, NULL);
> 
>         return 0;
> }
