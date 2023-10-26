Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60F38BFD
	for <linux-cxl@vger.kernel.org>; Thu, 26 Oct 2023 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="hPFV7ZT1"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16D11AB
	for <linux-cxl@vger.kernel.org>; Thu, 26 Oct 2023 15:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2NFAKN+c0RzhU5ySSRn9zwj3FXwLPGhjyYeygiKNen6nafRhyFpd6+gSZKzEWH7sgAku0yP02zUYeiAwzGIzBDpVR0JUG0/XABc4Uj34MMOaqRUZilrPME80KEH69px1km9uXdcY8ckX/6k8PIwE4IQ1yKTAbjioBRFrq4SfnlRWD6VXQoV/Ccqz4Q94d74G57H0E6b5etmSh9Vq5nYu5uHYpAH5lGbjK4sANrZO7RoZPx7nvz/8S75YrT4k46GCF6rFKue/pN4o12VpQsZ90mhcQzpctyE86JuheG7AfOac5FFfFE8eLIY4NtQTvMRNkjQ1tnfKm1PCgXZ4ojXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0B6kPcalmGGeXwSwnYA1J4WPCUcCyUc0Z6G+1wYFN34=;
 b=a+LbYE8L64M2pTJYNeHdF/wP4LIBEzWFwR9qHMTWosKiuYJf5EO/wzDkE3gBb+KnfnEHV+NzdARP0QbYmS7Ryb0pC25PRBVDCcetQXTfW3ZKuLGj+H04zBCa7rtL809KDMPAkieMZPnro5fJzwJeOs4j1ScKM+APfrYHycq4ERrzyVMHyOhgTchX+7z6bI2W8Dhe29lcB7BbfBNXep49AtB0ihnv37bl+YHdY8xeoUzP+mwTSm3FdjqeEH2kbXWD3fBmHAVGtH5UoZc6kMR58PWoA4AmbuGVCKdNrAwMRxL4s8jqGvlX1pBU3Obj32xuv36QjAuykuNY3ZzWVHieFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0B6kPcalmGGeXwSwnYA1J4WPCUcCyUc0Z6G+1wYFN34=;
 b=hPFV7ZT1HemLsCiwXOpjfctDYnf7K5ts2NOuId/OeL0Bvxzmw1B3XbLIFgYT1oVzEm4K/I9BKhqgel2vJaVGGywCwtqIICWFVaFUJL3JGFmM1DHTijANBxpSf6oruY/jiH72N8PvbyD85QncNExwdD2FtvbsLZKO5El1CqCIKfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH7PR17MB6815.namprd17.prod.outlook.com (2603:10b6:510:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Thu, 26 Oct
 2023 22:54:10 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%4]) with mapi id 15.20.6933.014; Thu, 26 Oct 2023
 22:54:09 +0000
Date: Thu, 26 Oct 2023 18:54:05 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hanjun Guo <guohanjun@huawei.com>, vishal.l.verma@intel.com,
	alison.schofield@intel.com
Subject: Re: [PATCH v11 00/22] cxl: Add support for QTG ID retrieval for CXL
 subsystem
Message-ID: <ZTruDdQabRcVAG4P@memverge.com>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR03CA0389.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::34) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH7PR17MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 777cdf05-db7b-4280-7baf-08dbd67676f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mfsrEjVe8o85JWhPuCMn3qHfxaG5rurwA6jIs+sH5mqb9ZPr3qQuxvf5xnQR/GV638GIyNqw+5p9ZNOIjp2nWmSBzypoT517tzaTJ816d8dx6zA1R4/HThIi6oiIhbh2LsyBpLLoCTfjjFCdcwuXmimr+aKNGWPR3mtWHXZPDZ4XIiltOhVl1gPFgSHRL2GH+n1j5nFSfCqqJ8Wbx1JKUzv+yxgVFuDZ8MPGAYLOZdXt3ZcDtbQboo1H903fw+9Sx7UfYzCIa8LtMJAr+gKZniPBYFIgWw5X3V9if5Ieaz18/PVOxrD8kCDDL3MRHCQj4EbP1Wj5ub+QA1FRjAX6dBgVBXss7mrmqMRAl4Bai6AE8ZPb0GeAH9j/LWUg4bU0Qf9ttVg4rE33wqKqtmRdIJhWQrZXkLzqx7ywWyDOmokMTnRViRVIuUAiGvtuApuIzQbCwA1i1HRdPc/dwqojoCXK0CdF/esVyElHboa3wApKfeW34b9qmLJoPpK4MAPXEozYR5v2sEPlxdIKErqo3tepIBYPZch1pOCFrXxLalU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39840400004)(366004)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(26005)(86362001)(38100700002)(2906002)(6666004)(4744005)(66476007)(36756003)(44832011)(5660300002)(7416002)(41300700001)(316002)(8936002)(4326008)(8676002)(6916009)(54906003)(478600001)(6506007)(66556008)(66946007)(2616005)(83380400001)(966005)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?31XHBjh2vbytCnI/CpcnrjcCsHUMIQTXQlTZzXFL3O5LUwbcxoeI2i4ImX62?=
 =?us-ascii?Q?y47P/p0tq8tZ9dmqfiisVRJJxPEO5wbjJmUq6pmbXy8nEBZv9wmJW1YmQKD+?=
 =?us-ascii?Q?eyQAMCuAzSN5mRdLjCUn2/mJJOEYslllOo7wpkHjtHkH6UHHwKgGL2bHJQ8O?=
 =?us-ascii?Q?lkcOVEX0nfwSh0ZBOW/ihqilvwdkF4ZOEvSuWPXRULNkNsL0lLY06D1XW7Rd?=
 =?us-ascii?Q?vhDAj8dxeoIRdCh3dfpY6guxNlcwnurgMNyhZtZ06zKmntJs/r+3BH0zlcMC?=
 =?us-ascii?Q?dA2EbCOFJtVRPaZ+YeK7MAIeGK9NZZRFJH0byUtIoCSTCMJG/sb3FjcSAP9/?=
 =?us-ascii?Q?4trdvkIZqcS6FuUlwvXSzoi18q65uJAfctn13KhqB2xHpYzVGs/xxMcQXfPy?=
 =?us-ascii?Q?810wUE7TgPC0ouFb/rdaVUPKZfN/bqtotYMPI7xBAcE9BFsWbeM5D3lecB9u?=
 =?us-ascii?Q?snuDZ8yoEAGe2qEBFqQGEdX3LHlQ041bJknXAICdKJocwO9mNecA9SfgMsxs?=
 =?us-ascii?Q?AR0fr6+cWAiNIWzgwpeNKtDRJCBw37f4LxjknkeTdZ1dtArjVHQ4uTC0M+TL?=
 =?us-ascii?Q?ZWdAVD2ZbHDNggBGxBuH6ye4iUCgvK758xzWO7XXotfLPqZTQ5iG3U1eCiTv?=
 =?us-ascii?Q?lWDrxQyKA8GHtafnFJk+ee3Q4W5Hg4yQoZt1xn1LDxiVVxCBXlFFxfrByVxX?=
 =?us-ascii?Q?CawURt8oKbJtfOVDgvAJZdEyFHeY5xsHDvDi+uspivTyrjUBSIsYfFVni/oi?=
 =?us-ascii?Q?laZ+zB2APv9h8qHfu+SLtnTvql99gChvP0Fi4kkQI6PwR2IKnta8XqITaDtg?=
 =?us-ascii?Q?RYgtstV3TNyj8adxTuaPt4hE6KARcvbBIzelCA+Hkap6pzY/PFP0di5lJkue?=
 =?us-ascii?Q?0R/CmAOt+cjq+eqIcCrgDV0fKacF6UE9/GdL8l323ctCWiU0VUAuE9HuBW0+?=
 =?us-ascii?Q?ZYP71CDxGh6GRzZydnvcOEL0Zhf1WuTp62xn+UR2/SbbXgMdiN6P3mb7Ui30?=
 =?us-ascii?Q?zAJIkbWVvD3Ia/JozxcbiQiolGrj+haNqj8WMxZrp0T+tp8J1+vdeTvgsR0w?=
 =?us-ascii?Q?klMjGUWphwkIsUJ2MrVwuLKMeGRHFPw4j9Ct6jy7SPuCMlL3/GX1bMVSITYD?=
 =?us-ascii?Q?PbLEWPvi9Eb0RmHPbh4WJ0Etf+hFZHB1g6GnVxR7b6wO1UGQvU3ehsJyLDas?=
 =?us-ascii?Q?8HvJg8ZOdODwmEtKz0/KfxMwM/DC2qEJb0YPyMktCh8Mb3oSPTN6Cc1bneXH?=
 =?us-ascii?Q?YR313XK2lAKrN5+F1NC3nVZbdzF0dGDqy43yh5nPYXeUyUCQKtmRdnxSWiqz?=
 =?us-ascii?Q?Km9DoBrU+PGVQdq9ds6TO3quJQ3niX9af+1Nq15UbTd5fGumyoFIPVSF2z7R?=
 =?us-ascii?Q?DTHo6VWrg8YxACrYzmLeNuASVTdQhDnKmkkx546X9JTzRqu0pAPaRBq5xqdW?=
 =?us-ascii?Q?5EfMEek1OPg8Wr+1b3b3hjWzxwWEjQ6gqjmJ893YXPZEFxEjXo2nnxvdHkKk?=
 =?us-ascii?Q?gW7+7mfg7dypiGmANfEAALqfwvo8PHoP40qx6DH5HnO2dPZzYXf1PmqppwNQ?=
 =?us-ascii?Q?WAe20XzEW1CqeXJ7zrIDVyR6ZfcnWlq9xlyVPwtghm8eO2Bgm1mjIACqPMrR?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777cdf05-db7b-4280-7baf-08dbd67676f8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 22:54:09.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idz2OTWOpMh+qFJVBAlLZvjCobhYFss7CyqoIQCn/yZBlozcr20k/vSc5mDsNSEOx36vVr9OCfrqNYVj9az4Yv8HoAoO40zmEomIMqIv9cE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR17MB6815

On Thu, Oct 12, 2023 at 11:53:30AM -0700, Dave Jiang wrote:
> cxl: Add support for QTG ID retrieval for CXL subsystem
> v11:
> - Add debug print for multiple DSMAS entries for a partition. (Jonathan)
> - Change qos_class0 to qos_class. (Dan)
> - Add verification of endpoint device's host bridge to root decoder targets. (Dan)
> - See individual patches for additional changes.
> 
> base-commit: 178e1ea6a68f12967ee0e9afc4d79a2939acd43c
> ---

Was unable to find this base commit, but the following commit is needed
to successfully build:

https://lore.kernel.org/linux-cxl/168677930330.2787985.15866363373310739456.stgit@djiang5-mobl3/

the remaining commits from that line (1-3/4) have made it upstream but
this one has not yet.

~Gregory
