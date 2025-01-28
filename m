Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F406F1DF998;
	Tue, 28 Jan 2025 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738056562; cv=fail; b=ABVfCAuVyt9ys1gwoyVFCkMcU+fv2kAsbj3+kYuT80ghoakL4tPlBRmzow4wJvc5rc+WuQUpSNAe+6ngrhrKGcnN97PJZAzICSpp9WaTGpVP5fYIwiOm+RX8dAjvrYgIVEQtDctsgxJ3VIO4Laoxslv9e6nhILBWyMr4VxwNw1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738056562; c=relaxed/simple;
	bh=Upa2nvEpVJ616OiWn4+X1qb4FdgoLxhtVFrU4nyRUzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PY2Ja2f/ZHQuu+7nPxXdK3Jp0DDynNSfo5nlFE1+df6Ltf5EdUdxuPcEc3spSdtWuBCpCH1M3MQBHFYjAISMKAyQhthYEIhjhzLoontcN+bu5FQ6pVvacvBe7nawmigN+y2j9YnJN0fRNv89k0gR7TiTmymDjcmVzAw3xL0UgaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zxH8pLqE; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zxH8pLqE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFCQkSdHWbvaJdHfbIGHcfps7BM1fjTyB3UhV28jWBAYOMJfZ3fyDcj0XkH9JU/zLsiQGex+eYX+Hvy7pdQMP1GQjezB5toXJsJrK7PTs16jxtqJYdOUvV+ebE5CTaEVX4LzoEYzHt+ibv9hLnLEVhNVboB3+CmXQWz+J/i3QBbPBTIlLgqJIQGMduXDfrkaBFSAUW2HpAp6MGIecU2HI9/SvVuwKWh2qgUD9nXSibem/qtS1mbwza08ITTccjvHD7/srxedFh1oKzRHVXVcNQcO7fTFWhdYSXTrSCr4OYnjkPqB10G225sfJayx7EV8iEry6XiVS6cBt3rMGi+L2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk61TBa3z8VLgqw3YyKqaXoornLmCjurFWRV0PRMkrQ=;
 b=UmfJo8AecORiHnBJlSYGzlNqnreJ915tjvtvFk5pBKnu7XiEm4Seg/s2N1e+j4Kg/yGo25II49np9+mvtlEXc7P1NncYAn6Y4ZHLHRezgDPpJIxRTa3Rx94gJ3hj0kg2tzOaroVdNHHmjS6wuF4lIp8fSSZNwkssPCUU8Jj2FogsLlkG/AFMz3tDV6RmjGI19waasyorBglbUZSa2PYeUBAqduGrMzE6tUqelEMPas7Aqs2BkSVzhQuW/jd8dKtijPycd47yn0ijzSwR1O2m82EsoAeRCa9O8ildMBzryBvSfh/oaHX0sDQc8DkZ+VrjnrlMPaPZAu6RPjvrieHrLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk61TBa3z8VLgqw3YyKqaXoornLmCjurFWRV0PRMkrQ=;
 b=zxH8pLqESMl9SEg9pabHsgPE7NyxHPnoKu3TkH7l/kiIeyHlsRslhJg0DhEFewv24NsWwb7ynUG9ZPEIdHGTmylEHqjC5aOZRq0w1ObWdYZEZy0XhD8Vbh5alkzIv4Gs6Su+IdYlaZEkFTJRK0RSiRWjXFui6NlOHv1JAKoSN4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 09:29:16 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 09:29:15 +0000
Date: Tue, 28 Jan 2025 10:29:09 +0100
From: Robert Richter <rrichter@amd.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 25/29] cxl/amd: Enable Zen5 address translation using
 ACPI PRMT
Message-ID: <Z5ijZaxrEuKDlpXa@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-26-rrichter@amd.com>
 <5620864b-ff79-490d-bcd4-b34b5de6f8ab@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5620864b-ff79-490d-bcd4-b34b5de6f8ab@amd.com>
X-ClientProxiedBy: FR3P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::15) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: cb953791-0a63-4334-05bf-08dd3f7e3b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U0A2AGHfdNNLCcTQzViQwYrDx6yGMb+ROUW9iSGwd0niKcTL1WprRq3gQRds?=
 =?us-ascii?Q?xIEY/eVY96cYr/hDEny7GCQBooREsQKXW96KTt0DYh6S8cFkX2OHh/WwQTTe?=
 =?us-ascii?Q?laOkP0u1xygzeQQl8IQjmeaJtABMJq8bujsi4D9vY8NAZ0mfhr7Ect2y0GIR?=
 =?us-ascii?Q?U7pqSxywmXBZ6jPQ+DoZNo8HE/LHFE+sL83LjZmFcBXTxc/nj63vfBQ7yfb7?=
 =?us-ascii?Q?ZrHMo1kJMq6T9AN6Z2+QlmkJd7TsG6X3UPx8fn7EzAFSIyxWw4O5hui+0gdL?=
 =?us-ascii?Q?/ehIA/zm0UxBZRMzWfQJSDwiA8kek+5gmajXIgsp61qWc9q2qdwIRqnDjK1y?=
 =?us-ascii?Q?VkFqBm9RqAODq5sbsL1YXOJ0EwncrnL7m0wJ3/xvghMWPJpfZGmdnGGTapOy?=
 =?us-ascii?Q?wMUHNnonzhGH1igLYTp5PVIWdkZAixfNu3vYJ+IbkYiOzP9jG1UTDsKytTil?=
 =?us-ascii?Q?i3evDDsFSgMOSA66GzRVNBgBRug64HGaPq0G3zWbFP7fCKn25XMFF0UvJajN?=
 =?us-ascii?Q?ZEZ5RXJozbnygHz56gbxPJlv5i75EAoVFmDIOLCNJsRBoMr5ynXfadZZ7uVO?=
 =?us-ascii?Q?Y35/Ph83OnuokpV8EAhngoqX4y1xsA1JreJsKZi/iBKm1Qai3xCFW6iZYdJL?=
 =?us-ascii?Q?tC5KuzWxMIAq3+TsIhdvZXrKR1/gy6evRhMvAzW+AB9PjmThxEjRXmzmLWPa?=
 =?us-ascii?Q?u3nNeQ5oHwA2sjqBcReAa3HtOTX3URJDjf2CZK5nYSfnmTkV7sUyvmIFq00q?=
 =?us-ascii?Q?cdpjrH/7oaqlVcREFqbh4JzZuXTmFV31yIftyZZTRo78cIn4zc6j+VC6+UwU?=
 =?us-ascii?Q?aGg1Q5Q9czRI8oXqF0s9umAv2l7Mdj3RvnIZngWmX3ZPWNae0+rPYXJnpoZb?=
 =?us-ascii?Q?1Yu6Ht71UqBWwA1zKD5V3h0wqYTQfow5vQq24ma1vmlS1T/4aoHquSKo0Llm?=
 =?us-ascii?Q?1hr+OKO5h5OPk1uZVYz7O7m3INTC727cEWZzrxpWWgPdbTX7OoVALPkFKPw6?=
 =?us-ascii?Q?fnJ6Eh6NldJBKIFtYuy0EXm7K27cIEpo3jfNpST1zH/LWf+QW6DMbcBck0aB?=
 =?us-ascii?Q?7BzhmDK14Os4cK4wSv0vxpuUv7U/l4AAnrW77Z10ZA1/+f9Fr48UVAFl4V7S?=
 =?us-ascii?Q?xkgVPgCPmw6sx//nyWtIG1EEH5aX70eIVcPaTPcue0qNe4OY8WjRcszq7iV0?=
 =?us-ascii?Q?WpRmr7KmI8p0EYzv7ZrvRd+Ye4H5huImbkiQU7VQ2Jhhy+x/MtEgmYHgpmTd?=
 =?us-ascii?Q?ANBT7gSH3b7Ji6ui9lHklXgSwjHpyRreGDzazFM2mew2stct0Jz+nAE+iAsK?=
 =?us-ascii?Q?R1zqYbr89lmwk9EWwoFpWHGd06spCfwhESTmZaQ476aSZ6bkaTKxZ1Y3WOcS?=
 =?us-ascii?Q?JTmzwZG/4nS4jyPie06D1o3rJaOD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/tCNwovtEQvDkZS6wQzEOeMoytPLMr2a/0fkwquDWEHqvc4vIuwHh/Qg0cJD?=
 =?us-ascii?Q?ujiaT+Byi3rXUA/ho6S+nS4bcporNavtPq7DkFSUX70BmQpvUs0GjSjibBsk?=
 =?us-ascii?Q?Y0OfdBJfbh+aaRac4rSAe6fkq/VvpDIiDKiKbKRc6TF7LrEmLcG3litSliEY?=
 =?us-ascii?Q?2W3ZoMf8OIlPo5mhACXhn6BxgQrJ84kR9KsHQu3YuJ4yDt7xSTWkLdyeGiNL?=
 =?us-ascii?Q?rPbh3DK+n6O+Smuj2ZIqfmxdPxcQdhx9pXjr+WngCvCwpdzE4wXucLMZOe0r?=
 =?us-ascii?Q?SPhsL5U4orIissO+laTKBon0yHv55ZhM/1S8ltqzYBQgrPP71qAQZaCrrw+V?=
 =?us-ascii?Q?t6FFKvixWAVSwDMyBOk0bk3lO2QDHkOHljE/qSyvotWnMi0qYAqlXnlhIe62?=
 =?us-ascii?Q?ZVnezatH+eUt80W9ZiZ0Qh0UTmZTd01YIkAaOZTg4dvsmIJ4qRzJMehVGmF7?=
 =?us-ascii?Q?mVtVVlLzrevdG/To9WGjDo1pcPlOvS01xEAW3kJej7Dhx4zHjJJxC03fAC72?=
 =?us-ascii?Q?nMeF7DA93/XoSzwFvUkeOTE4cWz5dSW29jonq5rlEvPU33Yhf4BDgLDcnV1z?=
 =?us-ascii?Q?CAXjE9AI/hLB43WtrpfJVpn7GbKaHKtI2vwaTlzd3wWiU+pm6FILTUDLe//z?=
 =?us-ascii?Q?lfysSrw0VmldYGgKci+ws5CJElT+c573mbhwdSe7g1DPcyMxrAHYJfBBkxd1?=
 =?us-ascii?Q?FCk3Q2a7ANPKc0EQc3O/8qW/LXqarrm1AUPGIuVKCeRdHil7M1jHIf4Yihbh?=
 =?us-ascii?Q?iC51V4dnLXFo5q2Taq7nWq+q940tBQaY+yI4eO2Dc6EA1HVmF0hbr5aTih2c?=
 =?us-ascii?Q?zMkTi3UK9MN2MYYPS8gRSVike38606UVI9C+AQLvJLnNaduD/AuzOPx+thLJ?=
 =?us-ascii?Q?OC14RKTrlD1dZnF3YW/Rt33IU1x5BZsFAo6XIXYESu3N9CXAiBxtIBgNZ3y2?=
 =?us-ascii?Q?PVkN4VFwJtZaacvu413Ahku0XIh8uQ/Sz5ot4lmt3yzmURSuD6DJwAQO+QNB?=
 =?us-ascii?Q?naQFgFOveCbgRM1/6QJXbK1fh+Gu5PT3W8oO4WOrnOJ4bDQousXdb4kXUyc/?=
 =?us-ascii?Q?rrxejZWH4AQk3BHqwRdVt04kKHauPQHOsD0HVj6yWHahnsiC5k4Eeqxe1k6X?=
 =?us-ascii?Q?cVC7W+FSTB5k9h7IXtQmDsnT/VpovwJnylVoEpvNoUPWuy2BGQvo9Vg4zJzY?=
 =?us-ascii?Q?tem2tQ0w6sRl5oej5sGzQB6nz7cksp0xhx+L5/HLjYBayRZ0M2flHVV/UulP?=
 =?us-ascii?Q?81cpqxGzNFshpruF8W4fhyQVQCCa0tV4DrheG11LPBzREAbQerz95pMFiOqj?=
 =?us-ascii?Q?nLwlA/hDkkxcMn6MJ1XzBJLMRKSH2lneZaFn/mDhEZS+rV0cz5pZZRsuBAOp?=
 =?us-ascii?Q?2i1sCZ31XNoMmjFdtnSyWIF4uOfR/ky8Ozgkm4nOVos5aTbF/D7NUh6ZeqsC?=
 =?us-ascii?Q?8sjbFvzxJUNibz+c9G2ATPqnuyOW/pYdvf32hropTSm89KhRsxV04zRg0nbC?=
 =?us-ascii?Q?9FSHobfO76gBz9hP5b9l4587Ljzd2iv0rZ8t3YlqosQfrzq3p3B9JAEXrcKA?=
 =?us-ascii?Q?klSldfx5HFhClGLaevs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb953791-0a63-4334-05bf-08dd3f7e3b93
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 09:29:15.6504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SLxTRgeJ32UgcDzRUMsWhClaqs2Mq2OnXXSZbNTDPjlK541YxeCtnEcGdEhJ+p1KKulhKTdSOWujjssAnbSBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480

On 17.01.25 15:32:25, Ben Cheatham wrote:
> On 1/7/25 8:10 AM, Robert Richter wrote:

> > +static u64 cxl_zen5_to_hpa(struct cxl_decoder *cxld, u64 hpa)
> 
> After reading through your discussion with Gregory I'm not confused about the function name
> anymore, but I would definitely include a comment specifying the expected usage and return value.

I am going to add that description to struct cxl_port where the
callback is implemented.

Thanks for review,

-Robert
