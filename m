Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C14242908;
	Fri, 14 Feb 2025 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538413; cv=fail; b=qKxG7DUo5ZntpjBWcR4PRENlKnzu39zBuoX3f3wHp3hGGQZa+Bi/FLyIiEtYFAJ+fPAwkjnzRSv9vju94FScVQout8lVkrRUrFD6fvOuXBlWuDKO3k5m0LnMDI+YXuQtDpCCuu5uNn56DDgoc6olJdvhKjcjHIb7G0Gi1BtzvAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538413; c=relaxed/simple;
	bh=fwgK/syCnw0fPRwD9QpRVZl+aB4vozp5p0YYjiJpW5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YX03m+kADwz1tJkUWE6OCr+gTG3lYZFV3IFT7MGVWDQJUULtuyg1Bdnh/d5yMAhYZoEzJdKkxJnGVn3Z0QVQ1S6bAoKK6zQM3huKfGu7gTmqZmQ/o+6Nuqv5RBBZbqVmzH6fnraBwCZc3wI7h0oFTCE5pmTIEVevOYqrBornuRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=afkMo2iK; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="afkMo2iK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Blb7JOTYmgQHC+a9IlWj8vaYpkSa9jGzRdeVV/A37f+A94j6PcVWxZdAVpr6pLTZNLwk0p4f3J65dzq+xKrcDmAKaKg1kuYpSMDuSpAZhsEC2TSxSCt6vOJIVKE05cYSPKGzBFaTd0+vGBhvAXwUlpi1hBsY4/ZSiTep2BiG/+5UH49lU/guabeTvx5asjlf98d2TYoKNWbYcePH5XRX4m1DwHgj9wo2dKgmuPa2/ZvAsqMhgWN6m0iQ5TDufaCoZxF6skPCc4sR6dgVlEXIPyERTEcDsmZ2j55PdDlF4jkgbwMj6uAiU+sLDSqgnC2OFqpzPKDlw+9uEDrS+fhmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcYQTM9B+wP33I1V3nXnnh2kGI38CjMaftD444t4y7c=;
 b=p9yCjPM1Q7TKWdJggPrx1ej1ssBgVsyzH7hjAaNNcpZ5mFdyCWGXcMxhnNT8n7IYyLPStJZhhSSV6k7CcN5v2txsCIUXHcqi4USFsE2OL1zfjnxubRPp6E5yO1KG3f+Tw8BCGwFOZRNDAWbW7X8a2twlePTPUmeBZp4qMBbGRUG5WO20GjuofZJahT87q73BlpNsKA3hXVfFju+9hi4kC6VWWb8pvyqomOG4cY39uMVgoxEzga4NQ/iQKj9OdLpbULt8qHBLYhoPL36OGmtGGGTYvlvKvgfQ/LJNPbnTmiFHvM13DKZslmeIWyuqQ9s7l44EdetNFuTfn9XK2xrfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcYQTM9B+wP33I1V3nXnnh2kGI38CjMaftD444t4y7c=;
 b=afkMo2iKx54HOGa1nEn7HcUB6/tR4IUm8cZjY/rrByN1SzEUQ9+DzChSqxswi0otpy2/R82R0Y9OB7x+k6ldUgH1DMOkBObutjtMH5AJqOQdnnHmfSFnpenRPdE2zatWq8oOCFe66nyjEMqa+8/vwqGQF+vLdzdMh0lHj1IAS34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CH3PR12MB9393.namprd12.prod.outlook.com (2603:10b6:610:1c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 13:06:49 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 13:06:47 +0000
Date: Fri, 14 Feb 2025 14:06:40 +0100
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
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 23/29] cxl/region: Use root decoders interleaving
 parameters to create a region
Message-ID: <Z68_4Lm001A_aYjM@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-24-rrichter@amd.com>
 <Z4VR_8Z1Qx4E8VSS@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4VR_8Z1Qx4E8VSS@aschofie-mobl2.lan>
X-ClientProxiedBy: FR5P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::7) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CH3PR12MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: 752894ba-dc7e-4637-90bc-08dd4cf87014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cm6YBOVYvDAF7U/OSEXiYQb3qLAb8WJ+0SKhuguqtVSkhDfrUuNlmvFhbMJn?=
 =?us-ascii?Q?QYc3/tyEUXzNQVE/eK0p6+htsRhYz8vLGcJ84XqcDoFL4xtwE99pws8YQT36?=
 =?us-ascii?Q?aSAY6zOkhQ7Cpmp9LWUPzCvPNx+lfhqExzeD8SRD6Nid3j4RQTe0xaLnA+gg?=
 =?us-ascii?Q?LlE42nebrYruuGR7ZSo+G5quEn8+LPxuXX2wn27i5K3a74IBjGQx5NwkiaVO?=
 =?us-ascii?Q?lTq/dMmOx+N5LHlhOq8+LnAx2MWdNqdn4za2F6KQfADHHdqq8VGTf4kj6SNj?=
 =?us-ascii?Q?6YcU49cOx7NfLzUqhmcwcHEvy6ouN45Rw+aRIW0vynzUbLXc71mm7IFJUOmN?=
 =?us-ascii?Q?6tS2CULkEpNNaUYPIYmx3f7mw4PzqtoTKLZQQRnW1QJMLLz89ewCWcDlpmCV?=
 =?us-ascii?Q?/Nxzt9psLkAFhjTjM9omp+fv3Q1iz7lSVM53SJd7LBtO0M2cNGkEKq9wJoUu?=
 =?us-ascii?Q?N8ys1MeMmFKteA4kSGS37llk134Wc/uWa2AlzVJYYiPFhVj64B5ZkRC/5z73?=
 =?us-ascii?Q?IHkA79LspkY91u0S/vqHGFQb9pQZCpdaDhxz+MvqqAF7+Hsxy3UctXMpgmH5?=
 =?us-ascii?Q?7sHEXBJu4dsrCg/ZmumBUjjggHkb2lMvZXGrSwe14i4gbAJ6VzpNb8dJWaLy?=
 =?us-ascii?Q?HHNIcW3lwzgBn43yXgavfAqZcehhKCJeRsJNEP3nzjoiZXvNA87s+WPLJJPG?=
 =?us-ascii?Q?GtGTOzrYDray5NSvaGyyrVW2ugpivQmJb93LK9I+jtbYvZo+clAp4QKqyFIw?=
 =?us-ascii?Q?GES9dXpPNL2JzFjDC332QS9v3a1wfKrjA0ZKmQWimRlLveKBNRKP8d7FqHsz?=
 =?us-ascii?Q?bjMBNoqBhRBkgWKZFU/anAcXPkkzlSG4bXKI/SwPXZX4Ii2bB9xVqW2q4kS7?=
 =?us-ascii?Q?6V9NvLP9umzT7R4ov/KQN96EYMQBR1ug0Y6EuJYCG1io79dijO8PBk+fCQBF?=
 =?us-ascii?Q?KfLyIKz+uzDfIrwwUF7yLB8PAI1Z2h71QhMVfFhdsjKIcFkJE2CvvMZ8zTro?=
 =?us-ascii?Q?JtFmjhDMdl5OJBmkPsGc1apd5K318qZdDz4hF9C4ZQFw3v++nRsmtYkHIcLj?=
 =?us-ascii?Q?xXRgXQ+PIwbkSugb4RNzo2BuaPHeaEm7IRM/Jb6FuzdOQFOHgvPbYMm5TXNi?=
 =?us-ascii?Q?QbZOG19Pi0/ltKNkgQ5jZtX1+Mj4t1C1n2VpQEDdUGktdhpqQ78zebrwlXfu?=
 =?us-ascii?Q?f05Jk/klWpVDxS40OkbrA+jzHjv8Sg5jRBvtGZjh3gcWm4Zv9m0yeWAwLilI?=
 =?us-ascii?Q?Xta/Rpsxa7Ruvu+jKLUF8Gfcii3hl4yMvp0sz1CVkbrfhpCKpTnWz8hKYj/p?=
 =?us-ascii?Q?YaIyTlduUCyGWiq5xJnvhRyaK2hUtdJtXhOM5i8xU+dgK/UJnNdtpyEwVTE/?=
 =?us-ascii?Q?Q0kVT7NdR8T2lgtONmiEi7OzGTQ/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FuASrY0yLdVeOz4JONydwn0SwyjaL7N7NkWkelqAw3qghxcOhOhvtb2YSZWE?=
 =?us-ascii?Q?WnJy9/d79hPMp+8ZQ65JfsgheDIYr0N6rKhwCiKm53GY37ZPXEFlGRaRqCoy?=
 =?us-ascii?Q?gOS2uvn58X/gxpM7sJoiLJKSlO8WkFnZR5djKUFFtczlNBPSIR0dmGfFvkKV?=
 =?us-ascii?Q?fVw1ACs6tug5i5CKuTZ3NFeBNiWOuHzegY1Okdncaee9xtwGZQQ47s6JLGhu?=
 =?us-ascii?Q?hR+/LqDMM/eI7AaLsmEFJxOY9Q67EkVVMfPNBhfXw4zymoJehdg6qWFyRZRI?=
 =?us-ascii?Q?So/RVtWCgZMrPZWIw7LjwsVogDAJS0LsCNTZR2wxjp5yYfAUYeMpOhp+wRP+?=
 =?us-ascii?Q?AQycaBhbToOoldn3oK2xxiNLCsvp9DJwJGjK1RKEmzt4MeebP3UOegnnjYn2?=
 =?us-ascii?Q?4TfDgKs/Ghne/jXbG4ayThmlyGZ7PNfZlS6Ctbh1v1WhThuNdjom7kp1K4FA?=
 =?us-ascii?Q?9s04wMZaLHd2l4JVn5ZPhX8g3JgG/LrZAlfDZeTmpf7wNp1ZD4w7X9vRiEzi?=
 =?us-ascii?Q?B+LDuFSi+cBzobrL4QVz0/f6ot3/L7+QYPETVL+BHLh0JsBot425PaEJ8fQn?=
 =?us-ascii?Q?i+dhzZjfwZE9dW842V6enRh028xMTmeaYNGyWRZiUxdQUs90jKbNSGk7nvCU?=
 =?us-ascii?Q?O/2JLjvsVvVQJJnA5eHc3yq4rbE+MvPBBEL6gewOJqrdye6WO3ech7SLKwLT?=
 =?us-ascii?Q?nbMYEL+fqSDoHKZEVcy8hHZIGZpyix3MrGoZ3CU/GgIvaOdn5ah+eS+emCID?=
 =?us-ascii?Q?JcceCOELxgK26cztf7+x2A1W8ExErzU3hsn3FCgYoOgZjegkOFjIyuiElfqP?=
 =?us-ascii?Q?yVb1tHWo9prQMSBt8n2GNBMOg7e8CT8q62leOHrbTPYZpp7L62lYuhXBCve9?=
 =?us-ascii?Q?/mfF4W0N6ghJi/Ma+ETbdsCCUec5qU/1sZxx1/M0zIreNhFLEvJwH3IFL8mP?=
 =?us-ascii?Q?Sb1B+bKxSfxJo+Xg8Vqg/eoK06tvnD3+O/IY5CLB/+mg//54n8OoyiH4NzSU?=
 =?us-ascii?Q?ba3xykwF1dNj0KLNreuGjEHTBQ62/xl/XKxXiBS3y2ZP8uuYdrkT60WzPDlQ?=
 =?us-ascii?Q?/D3TZNh4TZb8H4UUaxGaFQBoT1daS8lU1BFOvz4kmJND95WVRtwTjM5A3hmp?=
 =?us-ascii?Q?AXEL3iaY4I/2C6AgWbTfL/1dxrcZWXP+kYcKKXvk9PobdlNlTEaL15PbgZBO?=
 =?us-ascii?Q?hBfnXGADDoK9VFmfOhecbOG7lW5QBxOGGGkHXSeTy+8f6cpdtdoC4DHTcKzo?=
 =?us-ascii?Q?fAs5tg7bDV//7aMNvNGDi9XV8+Nkv/QzJGljImmHqdWko2Hd5ETvFU7VS5RG?=
 =?us-ascii?Q?H7E6v28o7JPperAwRGbW3yBdLuW52NN6FrOgc6JANIaIs1Fme7lOmh+IB1Sp?=
 =?us-ascii?Q?PgixbbNWcTKFPfvq2vyDdoGCuhJhKWTQwGwxuDg0tWgRNhDz/aoclip4ox2g?=
 =?us-ascii?Q?O+eHBf4dry8dxeT/h9pb0QaMRjV3FJG1wQo+QqUoGhTj0L+wE1RtYIU7NYKy?=
 =?us-ascii?Q?R2Z7lSdAq6fX9uJLJG9jMsvbvwvaqzyK21RtoK+avW7M8ZvTaPC6OzrQrh0s?=
 =?us-ascii?Q?jVOrg+AjwkVQgIbiA4ppLuIz3GtB2PefhGtj2tfr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752894ba-dc7e-4637-90bc-08dd4cf87014
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 13:06:47.4207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsI8i3BA1r15i4JZ7hNY+l02kv9xFzdaZ+W8joIdDM3jF3BPEfIp8TtDHGuJn5yp1Oiq4B9AQ10zOmnslETbsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9393

On 13.01.25 09:48:47, Alison Schofield wrote:
> On Tue, Jan 07, 2025 at 03:10:09PM +0100, Robert Richter wrote:
> > Endpoints requiring address translation might not be aware of the
> > system's interleaving configuration. Instead, interleaving can be
> > configured on an upper memory domain (from an endpoint view) and thus
> > is not visible to the endpoint. For region creation this might cause
> > an invalid interleaving config that does not match the CFMWS entries.
> > 
> > Use the interleaving configuration of the root decoders to create a
> > region which bases on CFMWS entries. This always matches the system's
> > interleaving configuration and is independent of the underlying memory
> > topology.
> 
> This sounds like a restriction, more restrictive than present.
> 
> Won't it block all region interleave ways greater than root decoder
> interleave ways? ie. disallows 2, 2+2, 2+2+2, 4, etc.

Yes, a combination of all decoders from the endpoint up to the root
result in the interleaving config. This will be fixed in the next
version.

Thanks for catching this,

-Robert
