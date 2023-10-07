Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD9110A36
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="OCdDsAK8"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA669E
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 08:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjT+ozTKbOMMW4CSjXZTo56Q2sDXf4gis1Xd6i1LLVxy+Ajihdijy3b7Man0loAyiwu1hHQMEZwX6WiIF61aNEk9JLofQZYH1vwDIbeF4yqcAI3DIq+4KQhtqwPydXpjqbmF8YfjlHLFHRqSpJ5KstbM6BmKtO7ixTS0sPejxqeEUbDTD3FDjsLDqgPAmIrBRAm4CpGv6j7+FG1+YhqTiukOIW0qK4WM1T5v0zwDE4XXnhIeNSSS+SIfjk6yfOowtslv1K4fL5FvTzC/u9oAXrqifTmL89JCshAm0Bm+WKqXx8BzXPZSXcLYWMaKGfC2pHXa9vIfE1fL0hW+YBODcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1aOY2NnXf/pj6GPo0K1Y5AMjZ9FoqSYuzwaQCODRsw=;
 b=CKiV5ibrjf9u2mbFSZGQK9MmKHkn8Bz1F1A+DfA3iIiB2HLZaP2X4HkJXq7Ix0gqPIE6mc4zZPD3nnEYmLX8nXs2qJQQl1S00RbHTCNa8tcrxBpP77srDsFLi8F4Ms/0ZKKp8FOSt/oDnVrLfnRWR+j6YCnFYnye2TLp/24bPts3CIuvTUkVi2n7SIxNZwS4pvvqJecyBQQ5lBBestiscJL9dPSOMxTSzpw2q9xKf6z4Zjgndwt1oyTzqr5+TRn0PBMQVf492jSqr/Q4DhamTMQnR0FsmMBPBj5l9ecpgTFa7fAbPjRha2WNu6lt9zkR/042RjR2QYOZzGyg+GikhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1aOY2NnXf/pj6GPo0K1Y5AMjZ9FoqSYuzwaQCODRsw=;
 b=OCdDsAK8RZ5XL3f1KMCW/bREYnG9+nmgrXZ4y5nMbkznIIw5+rs7fsR3zU4rCSx5yYXpJz8or27Xv00N1P22xzt064xGz/7OqOC0BanKZ+4xb76Lhx+2F+iPZuE/tSJW5sLAPfEYXzgSWXBHH7uv1MX3vRwe8IIe7CJ621Np9So=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB5754.namprd17.prod.outlook.com (2603:10b6:510:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 15:23:59 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::bdfd:7c88:7f47:2ecd]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::bdfd:7c88:7f47:2ecd%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 15:23:59 +0000
Date: Sat, 7 Oct 2023 06:56:38 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dimitrios.palyvos@zptcorp.com, linux-cxl@vger.kernel.org
Subject: Re: Questions about the memory of CXL Type3 device offline
Message-ID: <ZSE5ZltphjSJzaGo@memverge.com>
References: <20231009123947.951689-1-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009123947.951689-1-wangyuquan1236@phytium.com.cn>
X-ClientProxiedBy: BYAPR01CA0024.prod.exchangelabs.com (2603:10b6:a02:80::37)
 To SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fde0d07-81b9-4431-cb04-08dbc8dbc2b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jKe/rsaXxCOopr+ibeUASPdJ6dkdyvWuWlmyotgdqAp6l9+GCz8gRLOVSnZj55PZQCX5W3jny9THRnv4vT3YsGNgQmqBgZOteapKMlgM0Otq6VA4Yb+N1lTjUvyyP/3ZW1S73RLO5w+1xp50Ztqp81YVHJaKaIFqyAoDXztPT4Ifcylx3fOoDrvEImn9Va6q5H73p8pPTTg6VbkjYWn77QRq1YHARMe1X+0K2t7i3S29iWMAqu8x7xg3mvZv4nBfRJ7k4Q9Qd9aQT1h2wgej6eM7ajRoM70q6y0a2Cu0k2ahCIfd8XpNJN5iyr6QabpG2U+W6qH35WdCKKXpzktODdSxQm+Ja3dIWj3nuu1bTOO8ty8/dAmQTc1VcBYlj7cXv73VdN0QzN3sSSliolU0GN9lEnfGPHplyw1T5wUnZ+r2KC1B+SnfcmjWDRPkBl79vGoiwvY6U7ibq36x+qepEHZ8/H1LaPD6Ywg4VqIydAbXul/TtTVzC6nSld2qrJjXKEVhCuLtR6cLPHOcmTLoJXwaxqi5lAmo3pPsbOvKEIpJDr3XD8TaJFZVM3JgOU05
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39840400004)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(36756003)(26005)(38100700002)(6506007)(6666004)(5660300002)(478600001)(83380400001)(6486002)(4326008)(8936002)(8676002)(2616005)(2906002)(41300700001)(4744005)(44832011)(66476007)(66556008)(66946007)(86362001)(6512007)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8dtnmVk4yW3AFR4efnJ92GUMB8XPy0lhDQucECviNPpt1XzNetQW5waeBHY5?=
 =?us-ascii?Q?mj7uv833ZO3Ag5KW8ptw8YnyZcI1RHtVuRqITwe0wduMOsCJiNiWkVvHNkgF?=
 =?us-ascii?Q?0DOWtbJMekUZzQKybN0u1+0D6wNVDYgC4dNR03ZlSIXAtToPvcS2/Ib25+IW?=
 =?us-ascii?Q?JUuyzNZ9Dq6T+RJgSmBpXaFkISxEggemVT2NGrNrJu9sfTi1PwsomEBo6PoE?=
 =?us-ascii?Q?4Z9hbQaqLh/8gVTK5jXjFTB8X33yP/teobsgTz+eT2lK3nu1OOMcSBtzfXnN?=
 =?us-ascii?Q?l3JpftvwfFEdFwhIA0kbIWcgkxku4frp2QIZEZpOnKn0D7SYk0JVh5a6VvqH?=
 =?us-ascii?Q?j8UZSGZWVTxL2drlA+88fS89my7P0G/1BkW/GFSORzTBJzkxTil4c4nxgHbU?=
 =?us-ascii?Q?1l8H1tCQqVk3JVPq6kd4maSpZYIF12DiEAf48SV63hB4MEwTiNn8z7G/8Vpl?=
 =?us-ascii?Q?QK13RnS95M33bDjpJ9Yprbhsn0ttj4K0PK7a/gK8r2Z72qMj/qRPlCwhd5Ku?=
 =?us-ascii?Q?rVjtcEkNQWY48v3rcmVPhoe967n5QcwdHohI9+s1pHNkkGb+4riGG8d/Sar4?=
 =?us-ascii?Q?ocAT7tfeKVUkOrUbKV5+losU0Uv6gQbzkXpNrp/SFQZfUCvUzuMcXxZHdkgh?=
 =?us-ascii?Q?0qYyvm2MmTy6/UctCOZanQ58iXBQDETcuROF2aojwvgOnrAlNe5qPArYGf/E?=
 =?us-ascii?Q?77e2X+9Kt2OBvdLbIguMkFrCeDONjJamzCVDhavIvqwM6fSfm2tq5A2uFAWV?=
 =?us-ascii?Q?ccugLNSFo42sXsR8ensPlbP28KYU6m2lU3Uu0qAH/1IL5Nt555NSQnV/f7rV?=
 =?us-ascii?Q?ZyqDPtsYZhPErIzeUZpu49E57pAZnX3Dg3TBcWP0DHSGJtNDjAUJMzK0YloG?=
 =?us-ascii?Q?TGSq3//kottcy3UDiIKUqfVkVVMF+XW/zJxMmFDFtULSDjF1nLrKI+Plq4Pb?=
 =?us-ascii?Q?DuB/W5geSZw6R+AfM7iBZXRoLURLydIzGsPmu77YhwNQxigwi/+qVg4PaJeO?=
 =?us-ascii?Q?BiEF75Qeo91AbWihl0t6Qm1gWhOor7dx+zZaLdYvwXjpgkCyazP+GgA3EZBq?=
 =?us-ascii?Q?7IwVJjOgQ9y4SPVlOFq+fPGHl6ajuqpAuEU6ZLM1tjPWdOCUF/hnjw13wFSI?=
 =?us-ascii?Q?MftCUeBZT9Ll1Ioh5++rBHRnCmtSLOlBB8Hx0f4An0KO/Qhu7q5zvdKz4Dz8?=
 =?us-ascii?Q?O8oDWUGQclF3FQSfekV4MBXn7SnLg0q7QvuvFHREurcSRWCCL8Iw9rLWkJa+?=
 =?us-ascii?Q?MM9NjFnXOu0Uxg6ayKMnGQc1BtRuEHuCRjNnojD2EQRh7HfnEFj6GGmZI9m1?=
 =?us-ascii?Q?HgcvERuh9Su2+oekI+zmHpSYYs5WWMCahJVtBWccBd2tB/9I7gmxbTBbLpfc?=
 =?us-ascii?Q?dXU1YcIF/8Ywtby8ILeV2vXCeoiLTEXU/BupGR4JeTlWT3iwr1HZigJKAuc8?=
 =?us-ascii?Q?QmzJnHq47zY2wnLuTW+6QCQvkvAV7r+vmeE8eEAP7N5KsLcuLETxZNlQhUt/?=
 =?us-ascii?Q?MLDqvkvGl37DZetPSRRT8XRCuAAwuus1gmVf+p/0IOmPhGDi8eB7i32HsWVu?=
 =?us-ascii?Q?rLsAzdMWUz9c3lVCYTbIilXmR1tYVoTsjy/oZR+7XYygzvSItpI0Zds+CGgm?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fde0d07-81b9-4431-cb04-08dbc8dbc2b8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:23:59.4680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQHPgho86Cc1TzZz0O1N6+noxofGQjKPhk1+JfC3tn8BbiPG0dNfSNWyP7NqFt7grTqB3SDsXurogTqYgxr2Qn3ypsar8nrbGocHQkq1mWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5754
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 08:39:47PM +0800, Yuquan Wang wrote:
> Hello, everyone!
> 
> Questions:
> 1)Why the meomory of CXL node is still offline?

because you likely have auto-online of new memory blocks sets to false.

use `daxctl list` and  `daxctl online-memory [dax-device]` to online the memory

> 2)Is my configuration process standard?

looks fine to me 
