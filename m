Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE692DF125;
	Mon,  1 Sep 2025 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740231; cv=fail; b=b/DJiAMhiXcf96QEkQLIlMGTj4dUxwMAPMnMU+yKxbDSGL3qbq/z37w2E0rt1czIjBByl1kgPNlY0kfTxpXNH0HyOcfUvJctGm0yKtwPow4BH/g2c0aCv+mfVAl5GotPa767Bg45FheC7M/gthpcF6LohbQXaj40MAjFwKRQd/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740231; c=relaxed/simple;
	bh=61kdytOf0LnfHx0XPJI03MLyuhDwnu6rnKw/hJ9d5Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hP2rY1NgkcCVzHITC8fuuRD5Bo/SpW5tlWlic1M5pNQDpZhWFEyCFT7Ki0Y2wGqOWlKIplaCsolZEwWRvxS7xcJRXAHAYHEZeQSreziqLJXs6JCNl50bMFoj7SQqS1fR8K9WK2pOcSTzg+u8c3lHBshEgqf9GJLxhffwjEvY2cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2are97St; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2are97St"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6gbuFW7bKzHuye5tg545c6YE9lVBMRjPw5KN8uyFO4MHHgwwJWWBnD+KUDsRHP4uOX/iToQhqCnn5wq6nRGlFv/GdYqizqHuSj2cq9Ll2s7yzUw51yFV3KWNRS9IichpGSm7/ItvbTNXzy6yOFpevJu1MUjZNDkfDj9LNODQMIvqJf22pS4sPDBEV5wynbl277a5MmTfK+vgNC3yd2AL0UhbQmrNYdtZYHviFy0zumIWn0hPiu2zoBQXu4ovA+wF76RroruVYOV6r3BOYXP0Kzk6LchzkDA9xlmawgDFSbBfEd7yCO7C65w7mfT9JABzbcf6lWNlrnxOFuQd/zwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCU9ls1nX69ppn6m09Vtme3WiWBgkcKqkbKjB6s6EmI=;
 b=wslsGDt/mUJButEHamHyI4Q0gwPgutvtXmLYk4cSjUrPgTvsJtMfdpvxwIaLr6X7ucnWqL6jFVODlqRHenXv7bpodbL4IjtbxRrThNusJE88ByUtuVewiD/xHzY5iWshfrzSApZ9e9wy0gM1v7U2iH6bcEam/Rag/BTMjVhtk8d6QoSnf4xF5LT1M6kvQ7ORRnU4EUgsfi5KwvM9ZxUe1QD+/ODOJVgm5FsKaNp34cdtgabNptXkbhzh6teLx0CjqTAkzogKQIX3giG7tkPvh9Pas+P35xJdiveTWP6VNGr+aeyHgXNdLroq0PdtnmAb/3Nf8CUQjd/dh1a6qxwVIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCU9ls1nX69ppn6m09Vtme3WiWBgkcKqkbKjB6s6EmI=;
 b=2are97Ste7vBIA6619tOYxdg7sTw2XydSeS+Ki0PWzIplF9tnsp6JQXdMY4D3qNdbRqtA/ekJhb4hEE7M3tKQGuhfkfG6/seZgAssewCLnHVFqG3AHuoen3WA4N4x31QkEY813Ar92/OiTXFBztZn1pknlxMy8Ruhb5D/9N8b/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 15:23:45 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9052.014; Mon, 1 Sep 2025
 15:23:45 +0000
Date: Mon, 1 Sep 2025 17:23:39 +0200
From: Robert Richter <rrichter@amd.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Gregory Price <gourry@gourry.net>
Subject: Re: [PATCH v4] cxl: docs/driver-api/conventions resolve conflicts
 between CFMWS, LMH, Decoders
Message-ID: <aLW6e0tOI4HDSl7u@rric.localdomain>
References: <20250820150655.1170975-1-fabio.m.de.francesco@linux.intel.com>
 <aK27hvifBdqZK5-v@rric.localdomain>
 <4179950.vuYhMxLoTh@fdefranc-mobl3>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4179950.vuYhMxLoTh@fdefranc-mobl3>
X-ClientProxiedBy: FR4P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::9) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DM6PR12MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d953138-c98f-4ddb-db68-08dde96b8a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU9Wa1c0QVpXazJCZ1V0eFc3TjYzME92V3VSYm1hZ0o1cmkrNkJqT2NBQ1lQ?=
 =?utf-8?B?TW9yMGNtK0ZLbXRwYVNSWDR0UFIrZThPNHo0Tm9lR0RGVlBhQ09LamRscmxt?=
 =?utf-8?B?Y3RpaUV1K3N4cENWNmlUK3RPSGhlYVVpd1Vsd0t2NHJGYUNkbXFxbGxJTm80?=
 =?utf-8?B?NGdnT3VRQ0dkYU8wbWk5VnZOdlVEWHd5Q2RtYnpLaFova0lnTjBuZ1lVYmFG?=
 =?utf-8?B?MUdoNzRLRVF0YmI0L2NWMEVpRnZGVjNHa1FEMmxsV0JSUWNhbWZKWlZmWmtX?=
 =?utf-8?B?N0NtajR3MDI1WEdGNHFxdzljVzAva3kxQy9tN2lOd2NQRHZOaUxrbTBYOE12?=
 =?utf-8?B?Y0JraUlDSHRUb1hQU3ZaZ1NYUWQ5YnBpd3pBVjNBZVMvNkN5TmhwVmJIbGJl?=
 =?utf-8?B?a3haaUNHUVNHRVpIakIxamNqbGppc2YzQU5zNmFLWGt4ZXNEVEhtYkEyZ2FB?=
 =?utf-8?B?UC9QOHBnZlVGWXVmZnhISGdkUkYwY0pneUl0Umc2emRUSktSOGlKQ1VVN3BQ?=
 =?utf-8?B?OWkzd1kxZ1JqY25GbkxVV0VPc3Rxazd3Y2c4ci9YTlBQNFltSWJSQTBseWRq?=
 =?utf-8?B?Q1A0d3J0bWhoc3ZVVUFjeGZJWmFSRDJ1eW4yVFlDZXc2Z09idjd2UGQ3K0pk?=
 =?utf-8?B?QVJqaklKa0hiOTNRRDViMkc1aVVVOENNQWp1dWQ1TGtyeUFiYzQzUERSZlFO?=
 =?utf-8?B?dWNzZENZbmptMGcxVWNmcmtneEUyMmVQbzYyU1QvYndzUFpaK2VFcjJyK091?=
 =?utf-8?B?Yjh0REI5b0ZremM1Uy9sTzVQcUpnOURZM3NqQVZiejEzZ285TnhOaGxlSG52?=
 =?utf-8?B?ejlncGVDTG16NEFTVGdxSDJxZTQ5a2xHN1JzODIxcExyQVBBSWRaQWZGdDlx?=
 =?utf-8?B?ZHJ1aVU2U0xxV2dJVzBjZmNhNHBlOTBJWkV0UnRDWDdtSjJLeHVTTkNRa3lq?=
 =?utf-8?B?QVFuMnFHV2pJQlN5WFdMWlpGTjhvbDkwNzVkWDFWdWNuYnNuenlZenlVdkFq?=
 =?utf-8?B?a2RqRGQ3amZyRC9sNlp5Tjc5MjZkaUR4RWJLVFg3N3pPbzNZbGpNcFlodmk4?=
 =?utf-8?B?MlVqbXoxdHg3YmQ2MzNnMmhvNE0vOVI2QWpSUS9Va0FVa2JxZzBvaUJpMWRx?=
 =?utf-8?B?RmxVazdUajVjcmd6TmdNOXJzRlA5OExwTzBzYXo5azlLcGxJYzdrbG9zK1lP?=
 =?utf-8?B?VjIvUHJaa3pIREpBRVdDbHZhNjdhSHJyNm44SGhyZlZId1dkQmxGTyt1SmtH?=
 =?utf-8?B?djNkbkl6SS9JZ0hwM2cwTDVQcVBSb3d4NDc5RHBtaldiU0F1S0ZUVmJ6WXNl?=
 =?utf-8?B?WU9oV2dPRkZtTHVHcGJOd2VERDBNNlZhNG5OMGZkcVV1bm94cTFqcTlxaGRt?=
 =?utf-8?B?NlQ1L3pJL3Z6ZjYwS1FvRTF4a0xFUVFLTjhCa0NKRjZJQWpzd3RxNmYySm5v?=
 =?utf-8?B?MTgraWlneU1qNzJRVjVuQkRPa3ZWQTdhWXVTNGpWSERiOWh3dEU3VVpadjRu?=
 =?utf-8?B?SjQrRWU3YlpGVTJGSjVzcExHV3RLblZWZ3FzUVlCTlNWRGlGZlgrc2FwRUZ0?=
 =?utf-8?B?NERNbEMxUlVJT2NmR0JucG5VbUxPQlZnVmEvdEdrUEdJMkxZSlJ6Z2E3bFNU?=
 =?utf-8?B?WDN4ckxpT1BINlc5ZGtiRHlYbWVvc3ZkaEpYWm4xUXYrd2FKYTdQK1FVSUl6?=
 =?utf-8?B?eUdFRUY2SWVLNEoyYnJYSTlSbEN3S2xkMkdxakFCbjVBS2hyUjhHcXphMjlm?=
 =?utf-8?B?WTE2YXBnRGF3eVlSVVhCY213akVodUh0dnlHQUlZM1FFVHNreTU0V1gvNXZ6?=
 =?utf-8?B?UDVOaXRqRmE1WDJidWNES2d0Z3o3S1h3RXh2Z0hQa0hFV09sVTd0aFNuaGtQ?=
 =?utf-8?B?ekRQUFBxS1M0ZU9QL21JVXJYWWNHZC9JWGNJWTJkUCs1MlRQVVF3VFl0UHhs?=
 =?utf-8?Q?WW1+IIR5+Mc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K20zd3VDZlJJR3RScVJhYWkyRnZNRFVJMHhra3llZ3VsbXpPUDJaS0FBM2VB?=
 =?utf-8?B?R0Z3bmFqSENhRHRvenlyL29lMlZKa3J3RlNVOTA4Z0E0ejhvb2VqMEsrYUtE?=
 =?utf-8?B?Ui81UTVjaitFWjVuK2p0bnBDc1lQZlNhL1IyRytwdXRiRUhlZXBxU3JhcjNx?=
 =?utf-8?B?R1lTd21DQ1FRTUVWenJ1T29OR21McVlCUk5DMUtQZTBNTGVUZ0c3bDhuNzlO?=
 =?utf-8?B?T2ZDS0J0VWpmZklCNlFWbE1Cem85Q1F0MS8wZUlYcnMzVHJmUDNXVlVhMk43?=
 =?utf-8?B?OE9QZkRpRWlLNmREcmpnQzNTZFZQNjA2ZzBiL3lsNFNaSysrbGVhVUU1Nk55?=
 =?utf-8?B?UFJWTlJPNkVDdUxFOG5PWXlOYkQvVmZiK0NKNkM3UEdVNHVybE5FT0JvWDhB?=
 =?utf-8?B?YllCSWlmNlBtbG4vcGN0dkJLdmRrbHlqTlNYUlJpSUFaT3JhMm02b003QUQx?=
 =?utf-8?B?Ny9jS20ybnVpWmR3S2R4T250OHZyb0dmRlRBN3VJMHc5blpNdktSRHJ1bG5I?=
 =?utf-8?B?STJJNXFtSC9RaE1LSGNFaU4wVzV5WlJKVmFqMXM3aE5KMnF2RHNPbWVuSWlz?=
 =?utf-8?B?aTk5aEJ5ZVFnNFowTHpnT2tPNHRwSEkybFBNMEN4MEYzbVYwTzYwRERHTkRZ?=
 =?utf-8?B?UnpMc3RmUjhuR1EwRXR3QnZqY2NLR1Y1Zm9ZTzRRQStSRmJZQTVHQlhCNzhX?=
 =?utf-8?B?RDZxQzFldVA5TVEyTjB1RUZGSy9NVmt5NFRPbjJwanFGdlRrSUYzakJvVnpB?=
 =?utf-8?B?OWdWYUVPZ0hlMUZFaU5Xd2tGUGVGc09tWGw5Rkhia0pUMVh1d0p1TzBKbHNQ?=
 =?utf-8?B?NWtDT0crWUJ5akloTHMvY0IraUVqWjZqZEtiVWZyN3VsdjV0dHc5ZWVXRGwy?=
 =?utf-8?B?K0M1U3FYYVAzb2ZHcjFabmFVYllCaGhISVFwc2VuT0k0NVpHU1h5NnNldDdi?=
 =?utf-8?B?eEFNdzJSTTYvM1FOdnpHYlBnR0pVSE5oOThFV3hxNXhQem5Nc0NKNS94V1B6?=
 =?utf-8?B?V2JlSVRqL21SQmxtQjdZalpxN2JqNnBjYUcvSHd2NFMwTDI0NUJOTFFxQ2g1?=
 =?utf-8?B?L05jYU00c01FWWYyL0xLMVJ5NHM3aiswWDU3cTdwNitBQjQwQmMxU2ZJcjlB?=
 =?utf-8?B?bEQyZjdlSm93OVA4amtlNGRXRXF3Z2FaY0xBUGtVUGNRdmhwRjZkRU1Hc0x6?=
 =?utf-8?B?TXdVeFlHN2hXbTIwYmtRQXBZczYrMU9VYkJWKzh4WTUzOGFZOXlHQVpaZktx?=
 =?utf-8?B?V2lxOUFjOUtlT2YxOXZySDJOUjB4OGhucjRlcW9VbVZONm11OFBydlVzVW9N?=
 =?utf-8?B?TGRaaWdOeXlUNDNyR0g4QTRhTWN1Vk9KM08xMitoRjR0c2lRNWZCWXFkSXZY?=
 =?utf-8?B?SDRFcVhxNUFVWGxBSzJra01FUGZjTnUwM1pxdEg3U2c0U0QvRGxMZWgzeVd4?=
 =?utf-8?B?d3lXMnFodlVBSlhiL245MHllSkVDaFpJeFF4NUdlVmpIR2Z3NE1kd2g5Ymor?=
 =?utf-8?B?Ym9DMkVkSmsxaHNsd29GRjhpOVA5V0NLM0Y5WW5mQ3NFUnZBQXNsYWtQNmVo?=
 =?utf-8?B?NmJrc1FyRTFlU0hTMUxVK3l1QXBIS0tMYWgreXF1Qmd1WVh2bGxUSzcvazkx?=
 =?utf-8?B?aGJkb1BLelZVdHYyMi9jblRybWU3TyswcEcwUDdmVW95UjZLcEJjM21tMEVH?=
 =?utf-8?B?NEJuaE52eURTbERhamtmN2QvOGxxV05PZmdPYk1ZWVErTW1MRjJOTzJhMmZr?=
 =?utf-8?B?UXZlYVFwTVc3di9lN0hDUzFrL3NqK2t2T3d0andvcnZiZHp4bGVtQmZKZ3FS?=
 =?utf-8?B?dDJZYnVEcjVjMkVLSTVDdVJJQ0tJK0l0dk92RHd3cTIySnoyR2Z6S0QxTkNL?=
 =?utf-8?B?OHc4MDVwak5xQzZwREZSS0tDcDRtLzN1Q2xUYVZPd0ZNZzhJSldGWklQVTlO?=
 =?utf-8?B?bHFRYmJ2V2FWSkZsZThYcUVHMCtLc3o0NkxIMzhYVVF4NkYvTzZyd1JXbFYy?=
 =?utf-8?B?RSt4NlRyZEhsMXhqT21aUCtPR0FncXhoeEYvNnZBMlExaUxxK0pGTFVxVUZJ?=
 =?utf-8?B?ZmZiK1MzUjFOb3RYUG4zSTVBSUFFUVBMOC9TOEQ2SDY1OFJPZktUa2gxbzNo?=
 =?utf-8?Q?+ocQ1hIDgaMYrmNgODlYEfTwz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d953138-c98f-4ddb-db68-08dde96b8a8d
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 15:23:45.4357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgRyrmzBhPAT/97mlSm1lQgsq514cuhveg0/1+PePerHybgecOiwgNzLm6qXN2ZG+3w/jzHlZLPXi0x2mT9NpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204

On 01.09.25 14:22:00, Fabio M. De Francesco wrote:
> Hi Robert,
> 
> On Tuesday, August 26, 2025 3:49:58 PM Central European Summer Time Robert Richter wrote:
> > Hi Fabio,
> > 
> > questions inline.
> > 
> [snip]
> >
> > > +
> > > +On these systems, BIOS publishes CFMWS to communicate the active System
> > > +Physical Address (SPA) ranges that map to a subset of the Host Physical
> > > +Address (HPA) ranges. The SPA range trims out the hole, resulting in lost
> > > +capacity in the endpoint with no SPA to map to the CXL HPA range that
> > > +exceeds the matching CFMWS range.
> > > +
> > > +E.g, a real x86 platform with two CFMWS, 384 GB total memory, and LMH
> > > +starting at 2 GB:
> > > +
> > > +Window | CFMWS Base | CFMWS Size | HDM Decoder Base | HDM Decoder Size | Ways | Granularity
> > > +  0    |   0 GB     |     2 GB   |      0 GB        |       3 GB       |  12  |    256
> > 
> > Could you explain the zero-base limit and how this is special to LMH
> >
> Linux follows the CXL specs and so it allows the construction of CXL Regions
> and the attachment of HDM Decoders to them only if the Specs are not violated.
> 
> This document addresses only one of many possible violations. The proposed 
> solution is not general to every possible Memory Hole on purpose.[1]
> 
> The proposed strategy wants to allow exceptions only if the CFMWS HPA range
> starts at 0 and ends before 4GB. It only deals with Holes in Low Memory. The
> many other combination of circumstances that lead to failures are out of the
> scope of this document.
> > 
> > or multiple of 3-way configs?
> >
> It applies to all possible NIW configs.
> >
> > What if the HPA range is non-cxl already?
> >
> This solution applies to all CFMWS HPA range that start at zero and end 
> before 4GB, regardless of the motivation behind memory reserve.
> >
> > E.g. my system shows this:
> > 
> > [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
> > [    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000075b5ffff] usable
> > [    0.000000] BIOS-e820: [mem 0x0000000075b60000-0x0000000075baafff] ACPI NVS
> > ...

See below, it is still unclear you you are handling this.

> > 
> > > +  1    |   4 GB     |   380 GB   |      0 GB        |     380 GB       |  12  |    256
> > 
> > The EP's HDM decoder's HPA ranges overlap now as both start at 0.
> > Isn't that a spec violation: "Decoder m must cover an HPA range that
> > is below decoder m+1."?
> > 
> The HDM Decoder's HPA range in the second line starts at the fourth GB.
> I made a copy/paste mistake and I'll fix it with the next version of this
> patch. Thanks for spotting it.
> > 
> > For the second decoder, shouldn't the upper limit be cut at 378 GB
> > (multiple of 3, or 372, multiple of 12)? But since the CFMWS Base is
> > non-zero that range is not detected to cut it?
> >
> Another mistake. Anyway, please notice that all ranges above 4GB are 
> out of the scope of this document. On purpose. 

Let's see your fixes.

> > >
> [snip]
> >
> > > +Detailed Description of the Change
> > > +----------------------------------
> > > +
> > > +The description of the Window Size field in table 9-22 needs to account
> > > +for platforms with Low Memory Holes, where SPA ranges might be subsets of
> > > +the endpoints' HPA. Therefore, it has to be changed to the following:
> > > +
> > > +"The total number of consecutive bytes of HPA this window represents.
> > > +This value shall be a multiple of NIW * 256 MB. On platforms that reserve

Add a line break to mark the text as a special case.

> > > +physical addresses below 4 GB, such as the Low Memory Hole for PCIe MMIO
> > > +on x86 or a requirement for greater than 8-way interleave CXL Regions
> > > +starting at address 0, an instance of CFMWS whose Base HPA is 0 might have
> > > +a window size that doesn't align with the NIW * 256 MB constraint. Note
> > > +that the matching intermediate Switch and Endpoint Decoders' HPA range
> > > +sizes must still align to the above-mentioned rule, but the memory capacity
> > > +that exceeds the CFMWS window size will not be accessible."
> > 
> > Have you considered to just allow smaller CFMWS ranges that just cut
> > the boundaries accordingly? That is, just search for a CFMWS range
> > within the EP's HPA ranges (or even multiple CFMWS ranges) and only
> > enable that HPA range? That would be more general and removes some
> > limitations, such as zero-base and below 4 GB only.
> > 
> This solution doesn't want to be a general solution for all kinds of Memory 
> Holes. Dan has been very clear about cutting out solutions to general cases.
> This solution is limited on purpose.[1]

I still don't get how you set the actual base address if it must be
zero to trigger the quirk. How does this work with SRAT and what about
other memory ranges that are in the same range?

It should be clearly marked as a quirk that only under the specific
conditions. The implemenation should be separate from the main path to
better isolate the change. That was unclear to me. Still, there are
the questions above.

Thanks,

-Robert

> 
> Thanks,
> 
> Fabio
> 
> [1] https://lore.kernel.org/linux-cxl/67ec4d61c3fd6_288d2947b@dwillia2-xfh.jf.intel.com.notmuch/
> 
> 
> 
