Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9E62BB13
	for <linux-cxl@vger.kernel.org>; Tue, 31 Mar 2026 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774958904; cv=fail; b=dH9gEU22zGdquJTTnMOpzsYamyYrGTgSjx3GXVaoAhDUqk41npt9qMr1ntNcliD7Wq75uL6lCtCxMEdrWSTixQY0aF2ZVrwxo+2vNNpDLQzgh6zgCKmqhwp8d/6WdO6bceRGSzHpUOSljNQRm0ZP1wt0YT8dHmRgVa0tCuvlKV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774958904; c=relaxed/simple;
	bh=iqlZ6W2juleQc6ub69VW6/gWWjCIkBO0cubcqr7hL/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HdwEy91F8+a6k7GFBgUZ3SvCAXGV4QTTb1bUsBvosbyD8It5VEpPAHtrpShT/O7qS0Yax7LpzLuxeBHEWu4Q1+7uuj3DlkjxkpqgX8HRVBxlXOnIqu7wN9HljdsrMBRmDuNHqvksPgKKra2yepzW2vKaW7k71+9pptiSwztj4LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sSNXBJRC; arc=fail smtp.client-ip=40.107.200.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sSNXBJRC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wX2R3bDLqks3trWD+Edq/DrTz0sWS0Lxzv1igU+pL1jcLBbl7zVT6RH2GMNH0KZ1W51ItEm6nnouAQhTxjDMRwRMYcuRuqaVIKjjm0OOOsX9ZuAKbJJoIf4Az8twwb+VoT6Me4x4Ug//C+5ltc9zz2+UtkRBSeXWxhbpYcFnBhj1C1rvgCrWdstHKskqx8tCVSwrq8nI6ri0iGuDHFd+ROUuS2JEmgutHAPnetVdhqFibZjufdE9YV48kXdWp3kmea8JX3iigakZqxrHXoSb5ds9Gxwi9KTkSY8kWmGOODfKpZQjoZEffnk+BOeGvxKrcGd0iTy+Gt3iADQJsbuj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMuiR5FANByCN2kHwFzhr8xHmsKqH7ZwueFZJt//iU0=;
 b=qRS6hQn6rFQf5z/kt2OtaetCtCNl5qjNGjrDPJE4Ytbl6tVHwqLjzXVe3FX+jfZHyRecyEhpFKa5WzW21odmjkX8LHDHq+bMA71D4nw0HZnHjExo7qwmt3Qb+0X9auLdLTq3lqR+NU55XgO9nbZ3tNVqL61G4oID+BFo/zkdHkeh+9XZoTw6VNzl7F++NkCuj1B5xmwSLPI1vnFt1vFjr3BEJj/iKQfS0XD+uSgusEcQZCJBU5s2EzdIBI5OCi5TKT/Ku9RvaXSniA6sNizmEikOpUS3VEl2BVOj5H5vTPR1I9T/bSb0OAbQyPihp3+P6kSvVUf+zufcLndLbbUgTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMuiR5FANByCN2kHwFzhr8xHmsKqH7ZwueFZJt//iU0=;
 b=sSNXBJRClnnDQEadsZ4VjXxrd+QlR8jsiZvL/zB0FxXFO46CXobvWYyc+pTFMJCPWajDNHieUVS9Xh54Jl1KLA7wmnk9xeLAtOXXxfXxnQ5qFUEVCvfl+l4frqW/e4/rgTuz5D9K1TzW0Hurs8Q8hEDyWTZb8fhyhaAmCBrC++YQR3NT78Rg3MPTGVWPio1y3BEAHOMpMLb910fPNpu6SDgRBBI8mKMS3+W0hMf4DENVhcO390QHrW9wTqiE9in8B7AM74XyGk9endwE7sknQ5Kgc/PRht/woseRqLNUUsumMG0AKM3sw8XC6IAZpdaOISVmxGeKtOUv0MKSA/qNIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Tue, 31 Mar
 2026 12:08:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 12:08:18 +0000
Date: Tue, 31 Mar 2026 09:08:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	Vikram Sethi <vsethi@nvidia.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <20260331120816.GW310919@nvidia.com>
References: <cover.1772833963.git.nicolinc@nvidia.com>
 <0e8d1ee1557c54943dd15ff836576de4c3aa58b6.1772833963.git.nicolinc@nvidia.com>
 <BN9PR11MB52760A7F20A1CC2BC0DB018A8C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52760A7F20A1CC2BC0DB018A8C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: IA1P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: bbbf9851-fb41-422c-5e4d-08de8f1e3176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yE1lxaeKZFIxUBs5nVAfY0XlnK+g1isVV6lyjlAyuNker2hzW963C+Kacvf9SAG5Ue/CsK3V9sStHzyE2tgmbVQz53YwlFENz38bvnnChloSCE1RuBo7RBMZiftOQZVGz+vHqrf4Q0s1jUQardsYNeKqVIqlI1kgda8eUA01uN5RdY7V0AYwLOf3tinnP6TtBw9teWUt568n3GfVKbBCFFxIkzaygYyEzrKAERzRiUS5mJkFRcWktQfavsEA0rWZbvUk2xM9IyRfaw/DV90cqyZ4xR/SAZoxfPUMjrEVRSiTueVSMvTp8Iv2vcqiirJfVj+RAFgQgVbzJep84DkCMcJ7qQ8gdx6Gk9gSOVOnHxBOG/8oYdzLIFBC2mOSzunNq5dKFo+fsXstRs75hd43+4lqx1P75Ej0kQSMO8kHpTwNsLIwW34V5a58blH9lz7K2wo1ibc8EsR2vLpGqmektBO9GjJL6PFj83tswBLZDQJAkRvh4khv60uPsMQx1tIQAL7ZpHwsjDxZamLAeQBg8np+c0drNtTPsrifqMAl1Gr8bnekPBKS5V+e4UDHpDeew0Yygl2Pqpg803wFsao7iT4T9JjRAYHM6/6ShymxjaGJq1ZVjFj9ixey3LIAuiMp/Xs5V2LGkodCdmI60Y9sLfAc992wLtNP3p1I9yqCD5vLszjlIgq2T0EtNrjRqSfOfcSrS5jqmu9ZDIftiSxlSbZNn/I6XJWNg5BNtIjWn60=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MmsGayl4a5nm8GyQ2iCFMI5korSTIlRtg6xG6JKkYJT0Tli6YMvvRVLtzzeZ?=
 =?us-ascii?Q?MaqEeX/guIfa90U+QlZMrAIFiP6U0uacooc+dLI9HNQKem2b3DsbQrR/tkS+?=
 =?us-ascii?Q?0AdW4nLZi/rmJc4PsB2whQyUmpwvtlziQxXcWW5HVPFQ+H+VOFSRzSyihuvC?=
 =?us-ascii?Q?dnYpK35HDrLhGvYMF4TC62esVs4YkD2bWmGMDEUneeOcZj8gVO62eLQMRhVd?=
 =?us-ascii?Q?fjYxnBvkVfM0cQCYicAs1aPnxwo9XQPC3Z+iYRqj9iqdqNXzLGAoiAzHaGVf?=
 =?us-ascii?Q?WcXXXBHT4XDT3gQM56VAhLAtSbP1Neh5d9MPCG5JIDHHgyjKpjg612pe3EsX?=
 =?us-ascii?Q?cpTs4039j/ufcbGUb26vmBpwU5Gcub24HuEmu6BIPjg3UcbAIVL6eGFPXGKC?=
 =?us-ascii?Q?KL5PjCfHMwXv5qxLh/1T0eSa8QcqZ9QdSCJgADaajg3AvEbgwf4ip+35GWds?=
 =?us-ascii?Q?UIYzQc3B9nWd63+u7yOVRrAx+JdhReA9XOX25stX7UjwddBCVV5hlCBOPoqT?=
 =?us-ascii?Q?Q3q3KRKqbhatobUBJMyRhxcwfXr20YiEfYDZA7qvtH+ch1c3y6S7spxDEJP5?=
 =?us-ascii?Q?zhNxxu4Bpt0AdfFPS864tEuTsQBeHWDxFpTpR10VLDkXAEAFGHHhtdnFfCM5?=
 =?us-ascii?Q?+3o8Rb1/dBNKA9GN0hiaK8TcBEr+En+Sb4kilhERfkbBr4ogRinEA9wMjyHh?=
 =?us-ascii?Q?xHiLLDTH/aLEI7a21RUSF5qjhqL5isJe81fnVhWHJNg13yN2NFt5HQA0irMA?=
 =?us-ascii?Q?WWsIqNfqyJ9TARz0M8XVSai4XMtq12IBeS4WlTON71/S0TkTnhjo2cSLoOWh?=
 =?us-ascii?Q?sLE/NfGaBFi5AtqqBoM4j+UHiYKgmsRv2ClcWU8UUGolB6cqrAWUE1uxBeWA?=
 =?us-ascii?Q?bqRe17MRQ5Q2Y3Pp1YjsbpXMi6ZYGVSwf7psNmZUEFAn5sXW6bvxq2JkO4wT?=
 =?us-ascii?Q?tqSuysVINDpdEfDJud7/jN4I0LCy0TPrzkaju/qzotnXY5hiHuNVrQ3blbS7?=
 =?us-ascii?Q?T7DOVpusotYLDF59H4vyiApEMTQVY+no6lOETQcUfvSbiZ61DwfkMBREAK1N?=
 =?us-ascii?Q?bFYolH/iGsxnk9diM9boK+1APwh8737SExY+wCY2vpgeUTfAsJ2+o9saniGS?=
 =?us-ascii?Q?reqkJNxY+tJA9dSbiphqSITS05jGHJNdEcyPSF/z1C2lUqlyaarh88D24eYx?=
 =?us-ascii?Q?JwllZgn2ZDwKR8vk1Qktjb7LHsMHEcx+oqrV7R8wcoKx2oHaxYF6DeCT2256?=
 =?us-ascii?Q?RyZbgiTBxMwZtcVSjO05Zg39wMYYCCU9V+2kKfsgwv/JyxeGmXuf1f72bjWl?=
 =?us-ascii?Q?ynaGKMbMObURIRuSOMidmCDtI9Huuhfvo3dU1FTw0eIqOhuJ7MKAqxD02A5r?=
 =?us-ascii?Q?lmGvNVr8unbQe/zgv/DdOkxCwUbwEYl0IFI/nWEG4nu8tOFFuIlyzlaMLhro?=
 =?us-ascii?Q?hT+NVF2V7fucEFrMtNWuAKqaMzo5m4MU7pmR8N7f+KaZuQh47TY3LckdImGj?=
 =?us-ascii?Q?ItqhDCbHS361Bi0aDnR4YTzwWX27q/lVvslCYcGKZreXNnLzk5ICOPd6fplJ?=
 =?us-ascii?Q?1uyAcUc8vhbb4LuE+18HNXUItdqMp2DBSgPSfV5d7FF1AuP5LNqAaOLlVTdk?=
 =?us-ascii?Q?cIDlwReocGhi6bz7i61opbBFYBs48ciMX2QE2VlctR2zFItNIWp4Vmmf79tu?=
 =?us-ascii?Q?IOTOj86V2oedwwxO6g3VvbIAvatWmoossSs7PC013lwLiK2J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbf9851-fb41-422c-5e4d-08de8f1e3176
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 12:08:17.7987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9SUN/j/dDFXQVqbq1YHSHuXZTPJzIdRcHLVcaGN+W/Av1fWOy/CUt7MXCgJwmd9p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560

On Tue, Mar 31, 2026 at 08:40:17AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, March 7, 2026 7:41 AM
> > 
> > +
> > +	master->ats_always_on = true;
> > +
> > +	ret = arm_smmu_alloc_cd_tables(master);
> > +	if (ret)
> > +		return ret;
> > +
> > +out_prepare:
> > +	pci_prepare_ats(pdev, stu);
> > +	return 0;
> 
> is there a problem leaving ats_always_on being true while
> allocating cd tables fails?

I would expect this error flow unwinds back up to failing device
probe?

Jason
