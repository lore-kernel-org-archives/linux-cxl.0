Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010040.outbound.protection.outlook.com [52.101.193.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F5C335099;
	Mon, 17 Nov 2025 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763391496; cv=fail; b=PqDEaIW0SUF0lexjdsMHhktFeEt4m4qe5TCJHkZjEKTf3ZmAbk4MJrvvJxF4r4u88IMyboo2llSNWRiLFXoxLHKfGIN+Eoiatq8w4edDE/OACEPQPTctECA+6de55+Bns4ExysP7aRnqqNvMJZ4MNr3zjSKYQMPAg+kgu2ylbA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763391496; c=relaxed/simple;
	bh=9Oh/3yIg9p+xOEvCXqdtDqPsHGo4ccC83noxgvyepvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HWbBKMZKizNbfNv8s55owhVgunjN7NoX8EcdMPQGelReeBXKIxvCIKu16jxsQrwwnA3htZWSH0k5DqF9QtDFtsmTW/XqVEqITS7NHfpTR4ZBlSTXHjMBs4YXNPiAmW7dWECEmYy2al0m9oaYZ2dBxQ2AbMDBDIOewxbrgzK/pGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PR/keKS1; arc=fail smtp.client-ip=52.101.193.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PR/keKS1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwF/I3y1f0M8frq61VztxzBzZhIqIiLKtucHEtdlUMCHB+hkD3tH3/dcakIqQ+C/FPddMSgWBwK9b3nGopFZr21vjOBQ3e2wvcqw1iRNGKtVLBLe2ylhJ54CC7xmqctJAWFLBcn1v2toXxJgmlsDiFu8neU7xM5SWfqTBRaaeQzWnAAndtqjf+pfSFrdvAbP7yps6TA61Qaip81JDqNvPQVHROZ+WxWLBdUh7RrD0YaEBC0G6CTETBkW58z30dc7iN98IuD0zYcSxVqVbN9oIi7gcvCKDyQ5GDPeQd9ImIeMjXO2F43AdkLZjQErO7xMWaHhePQmkIQGF1F7tihZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Oh/3yIg9p+xOEvCXqdtDqPsHGo4ccC83noxgvyepvg=;
 b=Y3117BrL+TaU2bLudVTozeeXH2I+GImN0QLzPmCsxjkZCGKv+xngty/Sc5FXf8Z05pXxnMnhdzGYhSbs17hZE8gX3lPqzYF/TAraEuA8bUI1Bgk5VgypcWcNF1K4K7foaAfuGmpMKGpT+7S5OszljpcfAbVkoZk5RIgfpXY4pbzhg9aZ55VDhvYLfRdUQrv8TJdcwBpw7u/3UmTcSNC+nQR0FE+4VuY2LEEkYFz/V1TDaHhEAWrcyxfomL7JpEg4R86NF7eYt3t4X6NiVx5pcYXyhFpNkPS2Sg3xDiJ7bIavWHw1nLyeYwpsGfjdwCOMYzHg0Q02/b1mCFIAprC6yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Oh/3yIg9p+xOEvCXqdtDqPsHGo4ccC83noxgvyepvg=;
 b=PR/keKS1Xgh+j6hoi5E02aI2Ssy1dL5w7hdPEHalloVW0eEwc+jIMjid0a+HPKeMfDoukUlWkJAGurQD7eRG3BWAJG0t4t0zwYsZngwHiGGNOXwSz+Z+oznsHuzUuGDtk4lwXxnR0dR4pwzYmB/HqJO5ffhA01LW7Xv+gfcvfuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CY8PR12MB7612.namprd12.prod.outlook.com (2603:10b6:930:9c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 14:58:09 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9320.018; Mon, 17 Nov 2025
 14:58:09 +0000
Date: Mon, 17 Nov 2025 15:58:40 +0100
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v6 00/11] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aRs4ILR8EEwnfOtQ@rric.localdomain>
References: <20251114004021.1310661-1-rrichter@amd.com>
 <aReKmdOeHBBDWMuC@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aReKmdOeHBBDWMuC@aschofie-mobl2.lan>
X-ClientProxiedBy: FR4P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::19) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CY8PR12MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb268fd-3e5b-4d03-c55f-08de25e9b8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IM4uHGiKqaz13HuXTlh63ONBBB1S/PBaUqC90xciWnSABUizGVXYwMoDlfDS?=
 =?us-ascii?Q?UHTTbNpuQv9VXFhSaBxDsDejdG4924FDyMmW0N2VCMheixdKqPSQuoTuzN5U?=
 =?us-ascii?Q?zxoapvTWIrg09X8vn4LuCksvf+BDCthocwJFvOKpJH+ITNRQSR4AA54XeWbP?=
 =?us-ascii?Q?AD0Iq6LWXltRoDQZVPc130tbylu6HCzUXHuPT/+/ipn6mAL3YISYgXVRP2eC?=
 =?us-ascii?Q?4H/p/g25bTlnckWm6W2SzY4NIF/J0cHQX7YJmrUg2tm3IltdJcC63nqtlG+D?=
 =?us-ascii?Q?a/Obor5QagMp+ShGCfet6WGU4UATyi9Nw5NoOjExcOJkZb5moqNDE0l//DIJ?=
 =?us-ascii?Q?HO4aVZSuJYGa/CHOpPtsVYMVm2qIzn9ZiXgxnqJEunyKnx+ByoFfWm2/3nha?=
 =?us-ascii?Q?4wcq8s1OFJsORnmACdevPxt4zOClr6ypCXKYO7WS6fQpXdv8tmL3z8v3jWNN?=
 =?us-ascii?Q?4oIRwsSYdXbu8HBjsaQhjOhWzKb7s0JNuCKSh0o74upzgLH2+yDSzr71Nkpn?=
 =?us-ascii?Q?Ut+Xruj2lJAXi9jNU8/EATkcH1FsMqRfl3/FjeB0CG5N8S8eRgVh5TOFXybb?=
 =?us-ascii?Q?QRZlQlmda3pykLGWkzwectVk+RFBif6YldJfnMfa9llN0+TyBeZnjOIkECcd?=
 =?us-ascii?Q?ZNON23lvlAzLimZSNrFNwRFGY+mltEMFu6lmR7q3OPauBBpOr2D1pAGvrNhq?=
 =?us-ascii?Q?RyufAlABfFHVNp61RG/AEHabKrEMHLQ4vMKkEZEoVAH2q0qvoAONngzNJOxm?=
 =?us-ascii?Q?94dpHS1rgKYnJeMu06lk+56rvbQAMdgHcOLaZIMYharlWfgYvP1LvSgS+V8I?=
 =?us-ascii?Q?ukUn+qkRlxaEwrDvOa+vnudRFezp2vnQIldLTv97SKxMm0k5+dOFwKRyf/T/?=
 =?us-ascii?Q?WQ+BGV1UJwAjWr2q6qFrJpaxSEsSJY2R32YXiRr+gLg8AbGEGRUMGiAxLriM?=
 =?us-ascii?Q?OStV209Wn4jrpgaPZ0wvGsFdjweErRERK8ggWp+cX4WvHBu4ZTmIbUCXlvXZ?=
 =?us-ascii?Q?imtdcPqUyALfspttcNAZADvnsDIRj4J/BpiGT8LxIQNspSRV6Ehv81KT812s?=
 =?us-ascii?Q?lv5ZfW9ik6/7eMIBdwfgjTP+T8j/PetDZdi/sJ5OQ7Mn/ZPtwHz2/hN/96qB?=
 =?us-ascii?Q?TDr963pkHVnyn+dzNmJ7logXHX+qUYYz4lxnC01cQMAfXuYAV6vQWZ8edB0Q?=
 =?us-ascii?Q?EwzRoYvlxmV2G5t5msCMLGDa6syoTumZmzekth3pfw+w0xJpKHdW9ZFa3i7O?=
 =?us-ascii?Q?MBO9yfQlwmOzblBjKKgZat9DNCqIGe/pJGYPr0lI64PbaHwnDjAt6BPmiJKP?=
 =?us-ascii?Q?4WVO1yBvpPXXch3icW8z6hJSWcpP5kl/UsHyd0XEbUOhrQGWB6Ji6PlaWdAx?=
 =?us-ascii?Q?FGS/PzWfxU8XH9FZOpV1Y6foUV8LXTEJktGJCOUMImTwxlh1zjxjwRXaHyBj?=
 =?us-ascii?Q?iKaNlFA+CwXBxQw8gM6zucrdzFIky50t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?naJcE3g5QgGWk9JayoGQgn8b8eJFI5qvQPwW2QH4MHtnfLkDfvPeqlGZ8OVQ?=
 =?us-ascii?Q?qoLHkgm66eyLbi+dJVcAmP4OgyDzL5dlZFoM4Hq3HcY1lPgl32ByOVhpvWbJ?=
 =?us-ascii?Q?zmY05oxkCkvV/blkp9Ybx5Gbkl2U7h6eIDQ9IvBSMplWsIBHG+TFUMxydzvq?=
 =?us-ascii?Q?1ySvbHJhs8MDdDPO802kpboUmYr2kEtNTmmj4bsHo4dnk/Fz6eqt6SkmWao8?=
 =?us-ascii?Q?/gtwvOrAmD6eAmxutC0efy8CkKN+ud5mEx/bJQvQE3xPBSQBEWy/ZerLDDVw?=
 =?us-ascii?Q?PNqpKNJdhmkqCSb0bSmHMOSuLsqkZeITVAQuJqrQQs8JQ86u1gqusFCAOqbY?=
 =?us-ascii?Q?xhhBYRxoulhVO7znELWTZIItxg4SNjVJ6vlpBBlE4nLq63K27mkfVqdEo2xc?=
 =?us-ascii?Q?ePHSB7gmSJOFXerEWPMXkdUTZaWTbhgN17xsYpgwf3z3QvqdBh+Ka9xnHpnN?=
 =?us-ascii?Q?TWcvi9fBZYWHaewI+WPbO1j3ZT+zpPsb2j0AQGAviYLT8wJCk0yZ5JzxkHre?=
 =?us-ascii?Q?ELqVmoH1znICais/gFe3XgsA8xSg6Xv9xMsAEk1CoQPA8VVCvRgbFof/OPy7?=
 =?us-ascii?Q?lGr+u+03PYnIJUZC/0cIsNaKveK7ZxXP6OyOy3k7mEqpX5bmt9mW70jyEQnF?=
 =?us-ascii?Q?ovtkFO8Ok8PHBFdSgYOItZ3dK+V8uZDFkBqZ0ksKeKWTFV/rqyuf1y3otYvm?=
 =?us-ascii?Q?yOU7A5Nk9hM7mvqMNJXyd5mINCGJiajr1NdM9/Un6Y6KKlNlPu7QeDrFZVAt?=
 =?us-ascii?Q?NE8dUi9uxOBjRzcM00/QOqGQee9RBXjTNvqSLALtaCLii/l6uV40ZaP/7g3G?=
 =?us-ascii?Q?OqYA6hl25h0NMaPnPwheiLJCF79Tk4s3BiC1Qm1pjKG2M0McuzrtZd7+nxA1?=
 =?us-ascii?Q?K5jb9ORixp/uWewZYRnQp76Rou6HDm91gc2DvVOaFYVA0i+N14ivP7gEzpTE?=
 =?us-ascii?Q?ftJT/YZYS+mwMOe/x99vq07eU811Sh6VpAhrNbM8L8z7K/BA8leMf1dy9P4j?=
 =?us-ascii?Q?DR6ftiYmdcB7sNUmS2ZCqB+HHHnHaIWbgNj2iC734hjDs6ZOwGIdbm2KI32i?=
 =?us-ascii?Q?ytMil/riy/VyNS7PB/+f0uSUcXjs153MVlhBXTGzydTYWYnTdahwhNIt4wUI?=
 =?us-ascii?Q?p9OZk6WXS5fA9bBBpq8gBoV6ymI9yoiyYJpo/gLfaKvl7h3hYN9GbimUqBC2?=
 =?us-ascii?Q?CHxDBDj/nR9pGgvMMtMcnFDWzp2wn5AW3dXtke+RJ7zGE6KUNnyORvupN+2L?=
 =?us-ascii?Q?4qYhfY3941QDNj3wEywJV0erZjUYvlgfTfSwvOH3o+pQCO7LqNPyFwwgVmzX?=
 =?us-ascii?Q?2kVH+OmodxddAGp2WPy59g+K4iOgWRJBVTvHNZfgeG72jgd0Fg8jEbsr9G4f?=
 =?us-ascii?Q?hLutwfhZIAdgYtVHBCB2D4BnoTLpBBdb+pa0hxHNhA4EYO3/E/tIEGd/6CYY?=
 =?us-ascii?Q?Ujo5PdkCyKZYwoG/IotHTKCE+NOcMONxnHaRKAijqCf00ytiXHZjqmNWhiyR?=
 =?us-ascii?Q?zqnvN/ACPqtswnt1Z1k3+KJAuLuPa/tFEY6/azr4WPDtXEIujOcNt0UWHdf+?=
 =?us-ascii?Q?XnvfsJhOX02GnjsLeHJwDJbG3tAEvs/gV8sGAw0a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb268fd-3e5b-4d03-c55f-08de25e9b8ea
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 14:58:09.5091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hg3/M17ToJS78Q5wKIJIf+p6Hcwi4Ab8M0sc9SRnPjwOtvEBkBkLpn9u6g/id6Xi+kXZ+Q9ys99cn63tq5Fmxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7612

On 14.11.25 12:01:29, Alison Schofield wrote:

> Does this work 'as is', no changes required, to support DPA->SPA
> (used in CXL Events) or SPA->DPA (used in poison by region offset)?

The PRM handler could be used for to-SPA translations, but it might
not fit well to other users such as profiling, tracing and error
handling. Those users are executing in a critical path from a
performance or stability point of view. Performing a firmware call
could cause problems here. Since the to-DPA translation is missing
too, a different approach to solve address translation might work
better, such as examining the region parameters. The kernel's address
translation library could possibly be extended and used too. That
needs to be figured out. Also, my main focus for the patches is region
enablement.

Thanks,

-Robert
