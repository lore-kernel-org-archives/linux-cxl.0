Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABE8145A0B;
	Thu,  6 Mar 2025 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277937; cv=fail; b=qGPOF+i9fp7ki2iPOQVjr7boq8MniIJWSt0BZh8SCAqIcTOuTV52qb/RDy+VZdNrOQCs485/tuEQDJSQfKNsx2XJgZS7XVnz9Ue51VTEDco1aPeavh9+JzmHfn8CSUWk16KQ7O7BCaKbAA6xiziKOJhohoQAx9X6EOdW3YhQlko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277937; c=relaxed/simple;
	bh=BimlwdU4fE/LbJwmXgl/6ddaPcaS7ftsbJvlpgrWzyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ksQAbUWZe/+UYlRR4DEkR354yAvt72nUBkxAgj2xqrkCvskLvvyrsoguBtUD1Ee627C6Doguf8KSDyj9bc/2aAhxRDxZPJY9hrHhTrc94KgNChcSBp7JbYF9cVsGKinN4OkV0ytVunm9HagH3LMKomMKKOL7tOkD99Fg2BHX5gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f+APQzx7; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f+APQzx7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biKvE7MaeLTgxkApZzYIaQZrG9+rIxDxZRYCs7oIoeCoJL+kVcUtGS9r0xvFOp02QYYjeDGIQnIHGYKs+N2xjOdyiXSpGbnN2+uzWA0N8E/c1t87NS090cMxKhf1omKVLTdI0fn4YdqWeTA+68Vw6KIOcpdJVCVMf5KeDSSV1wsD08yz4lPFsP/fYoEKwbUT6MrziQyQLX+SOs2kerLJsav034ReSNH2jzbBeJRxN2+TCBWxuun8V+dhlVbDfPN8hPWyy5Qh+PiJemiualjEVQqomcDNbMMjYHUFkaTjzaTf0KJfncudfwy44uvAadb0oOqenypBIxxPAAJQB7noRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrD/vku1nRxUQ1ciwICv0hhvT0srWMXuNwYSHzStJiY=;
 b=ilQbY2QeWhJHPRabMfckf7IXelfivgAp+67HBK0BKlZHKXXu2MidzZQLXxAMpgaOdpWd18XDNxYyFD3tN+DUN4bCRAb5+6gFI37HkjTSGAosjgMX22qL1FCm0+YIj85PiqNHxAN8NQYJbj09PvgnhqaP0wEvWG7eWTiovUdAl9b1XhrA9ypgjfaWp2hi9wVPHupxJmw05L68az50OzBFhitvB33OvZoA46IatjfshfA/dHzv9mGaAruG2IahEiBVmelvns5sRhYhDMxFNqkCuBWLh5KSdxV7IzkSxoDuAhb8ow5tjdl0jvbU+btPevMKBvKT8vZZeyZmkkEGESSm8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrD/vku1nRxUQ1ciwICv0hhvT0srWMXuNwYSHzStJiY=;
 b=f+APQzx75z7FSyxeM0zvH5mXQ0XALAqduOEMh3y7NMfQL//CDb5v/A8R1d+Qh+KSV59fTqwHs8FA7Ag//nyoKxNIT7xKl6WJ7fw5qkyhRle6RVbCuXHsd1O8TSMOsyKlOYXfpqVXzENh3a9PEFlRLofygT3Yu0OImJYlDhk0WfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 6 Mar
 2025 16:18:51 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 16:18:50 +0000
Date: Thu, 6 Mar 2025 17:18:44 +0100
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v3 14/18] cxl/region: Unfold cxl_find_root_decoder() into
 cxl_endpoint_decoder_initialize()
Message-ID: <Z8nK5AdjeaNYjSbl@rric.localdomain>
References: <20250211095349.981096-1-rrichter@amd.com>
 <20250211095349.981096-15-rrichter@amd.com>
 <20250214163346.00007ade@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214163346.00007ade@huawei.com>
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CH2PR12MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: 9354f857-bd19-40b8-fec0-08dd5cca94b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pq9G49l9JnUCPvjJ8F/FcqIZuxU9q/FW/v0T621v3nLJMSGQYxOnz2Smaoid?=
 =?us-ascii?Q?ipuFBOm/L0X+EW/XViowKrd6prXYq96EUBM0rkjxx9Pus34enPft72EuOgWf?=
 =?us-ascii?Q?9XpotknRKjd+zf0nQNdjThLWVGKZikL3UIjdMorwMHHKE5J8aNvixhV8tTWv?=
 =?us-ascii?Q?19lwud8dBpu2p14Xa5Phxa4F+rM6xe+3fUJ2dLLf5/uJIkuhFtSI6twBvB7O?=
 =?us-ascii?Q?JnxSzxXjD4jCT68kHxa4o9PEkml1164sW+/tR/XU9m/Tz8NHjpV6UsAfzDtw?=
 =?us-ascii?Q?fyh1Z9FXbVENgdSFyYt45uiAXUue0m+codAS4xMRjcgFpfLfYV27nyvDRS8z?=
 =?us-ascii?Q?ElbUHqF9BnNCe/+3bMwQwdvlkrXKDliHCd+7kRVHMizQeHP8VWGXXr2SJNju?=
 =?us-ascii?Q?uvtOSHm6f0/h0zaDBZ9eyhL9mbRJl0QFYkrR8NeuvlsdjPHVqShMZ7iRMcBJ?=
 =?us-ascii?Q?usQEphGsnBAHtFBKGY9l0EJLBDb67ML2PI0qN3eOw5UVuaEE+PtmSzW5iWDe?=
 =?us-ascii?Q?g7/Yn4g9VerQ9Nrl4ePN8VMD+ZwDN3Ax3AeVlbyp+wxMW3K6QtONUuxhkH/G?=
 =?us-ascii?Q?hiJ1Q5+Vzxpdp2+kpP88dnQSXFmh04skDw0FL2PowWAfS14Vx1RdV9rEf0dR?=
 =?us-ascii?Q?FBMAjju/dbxW9D3w0wCmeKbZTpQ1UWyLjQbdHujZrR2rBWmOmCpjXrdwSDoZ?=
 =?us-ascii?Q?xBSeyvCYvX4aTErDUjyCVqUthxm4eNk/ncJHlUkI7gEN7SeYsI/tlejNZOu5?=
 =?us-ascii?Q?7DAARQmnSL+SSy+ZTrRHcTcof6XR0ydECc4/oae2ipDE6SDNH5Np5eWzWDvt?=
 =?us-ascii?Q?GbB/BUTReuhJ23CaFRJM2Ch9l1IXS57GWZ0DgD1wNiVzTeN+TCks0lx2unyg?=
 =?us-ascii?Q?kJDx7jPeapyiq6JuX0mtZIWhs/ez9wdgfDwXKAfURPHcjaHwjsnXf+Dn5dwn?=
 =?us-ascii?Q?h9bK2W41/dqVmMI4Bbt28YrYOglijc4KKrlQcoG2qnM/xiIF/r+gNDU4uJZb?=
 =?us-ascii?Q?6fsrBi4CAco/02hZqqbL4QnARnEm/HLAYZ56Uyph/f5F9EtT8tEqWyHX7vnv?=
 =?us-ascii?Q?wdV/mctPHDYMqxC9GxPRtiuSJvB09D33+58mZJQ6prls23SG3cELuqOIfdTo?=
 =?us-ascii?Q?HoBXh/7JrW5xIm1TRhBIpKbZBCuGkpM4zdTIJPWwZlOHI/KyDT1sT5f04XSK?=
 =?us-ascii?Q?EZEpMpg937box1clUgGLNXQGkV5i+6l1BngjCCS5wJmtIo98OaUK04xVxSxL?=
 =?us-ascii?Q?UXKjV+lTDIALL9FaXq4SG9aZVDXQ8cQickFAIauA3FgIw8e59vRv6bqDquET?=
 =?us-ascii?Q?2XHw6PCyyqV2PZSscQ38KDuui2ueBJbhCMxcwMksCBNDNL6bWo4CIQslvtYQ?=
 =?us-ascii?Q?FOaYEIHPmCBDw1IDUwr2JHAd3gZx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VhQXkyOnH7iW/tG0shj1CovxY40PAv+WAJogI603UwCtyIViMMRVEJFIIZbI?=
 =?us-ascii?Q?zjEa9g1qWgVUYzpQ172CxZx1f8MYTrxMcqSNVAn6rGRjxvbSHsWSoH1lsk66?=
 =?us-ascii?Q?W6mGUx/JCSvAz8irOwdJuWYLOBZ1IY35Xx3IkOTX/a+EQ8HjD7ohlIw070yU?=
 =?us-ascii?Q?Lk9TkgvGTdpzfbqUKFwCcjwc8EY4DdhF6W0X5oU4+Nlvp9wB4RXD6LQ7Nhu2?=
 =?us-ascii?Q?Zo3zaM3EvJNTfZkZY0HAu9SyV9VmwtuKurM6NJhowwHj3IFqwxq/gsKuoaTq?=
 =?us-ascii?Q?Sn4eEsIpTAZGHF+L1JfQf9KBrnFUcbHJVKTZx9DTBqHBIiFHncVVunyRnSRy?=
 =?us-ascii?Q?1UG8JpTRQPj/0l7De8clkQynK0YfwqyE5ZxT6tgl+yJCPjb4KFkfJ/70KlTZ?=
 =?us-ascii?Q?Mz+Mn07QwV9Wsr8AR+8MXAdnZ2lxffUJmG6JKZEyjswJrolBrpyhjdWNzYZD?=
 =?us-ascii?Q?BZ0LnQwblem5QBMOMygeFxxTxjv4kW8OxCZIvHXjgeuAUujybPT+20U3V3RK?=
 =?us-ascii?Q?JFztX6YcP+xLGafV44m4XhuWbbTu/jAlTcM9hy1li8i2jEvAHH+OajPq8bJq?=
 =?us-ascii?Q?t58x+uSNXI2GpzNFlcfnWAUfqDj7H/53FNxMutVmTNIcfkgjGeOl/gCmdsrU?=
 =?us-ascii?Q?l3UDCpJJkM9mXHg7AIDI5UdyQL07UrorhVt7hSc3zvgirktPbG6QrglpncZO?=
 =?us-ascii?Q?8T2smUn7COSRbk5Zd0bNlhH4mYIYN5ZfrNJz9mJYEim9Zcuo93Va8lwsJU5t?=
 =?us-ascii?Q?UyiYasKnSPlBiAUEsVc+Gz8I3MX5QvEaCaLgzQUpRSniN00XBgX4FYIuBUoo?=
 =?us-ascii?Q?LBHaFsVO1v8/silqJhhnskMc1q75OZiK3yratGUbgicZdM9dzuK55LYhh0TE?=
 =?us-ascii?Q?bYJZPhVmCxC+fD4q/i5D9qhEpjkMHCl2tNbvOcblDwJZJ7CIztv4c3LwcLSG?=
 =?us-ascii?Q?cH+xeY02rz5hdV028hmmpJfarsmvObftOnmIrdsicldifFQi7xjAQWDhczay?=
 =?us-ascii?Q?rl+P9HRHV38+EXOJoRyxCWK7YbRQdaujbDA/1mO+3CI/BDmcfjq9iOAbvhlM?=
 =?us-ascii?Q?yvMjmxBbVwPzYDy10NumTOSK9ZXXp2S3OGvCccSZSY0OX2/oshBnpX0DTYWQ?=
 =?us-ascii?Q?ozsTtYyEEIq8ZPKu4mbV8WGzMvotbjvNLyk2Y+BIOFyEC2t8z3s0QpUmD0Dv?=
 =?us-ascii?Q?D/6EEhN/HzX5WNgdTeeS2NgBp1H7Xh8svithlrJXAxpMD7+gzZoQl4VPuZAE?=
 =?us-ascii?Q?DBa9ke+p41y0NDLHpEdH5Zk4291Mim6wPQ4gEp6n/AqL1goDT7WD0EP6AUkV?=
 =?us-ascii?Q?ckllA8K1iRXSQloFlJwZXNKtufCj5jjAovoo9zTyq9zImyqFtRJzVUEr/YuM?=
 =?us-ascii?Q?v12xJF/w2ZJSYGK9GOMU3YNc+xyaP2E5k01DNRXAqa4cXfjFhls4QFFbDv+0?=
 =?us-ascii?Q?VBtMD16Ko4CU2z08nXrYWbqLJmY4EOncQM/ZkxLx+ZVVM8qDX72yk/tgI2eC?=
 =?us-ascii?Q?3EyyZDLS4dyBwTKCz9AYJRGYvss/650MMYPxkXXcqRIlhB4E2Hxy8tNxr2mS?=
 =?us-ascii?Q?uR1yn3gvZStpsMJqEXqERhw0aZeMHTvd7E+rWtjU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9354f857-bd19-40b8-fec0-08dd5cca94b2
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:18:50.6907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36fZarQ1IkbiWExLmnJt1A97pNzRkxIAsU3yy90/jR8mKuC71wV0i+zuNrIM3576yRcIKhu0mE9+2A9NrgQz/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168

On 14.02.25 16:33:46, Jonathan Cameron wrote:
> On Tue, 11 Feb 2025 10:53:44 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > To determine other endpoint parameters such as interleaving parameters
> > during endpoint initialization, the iterator function in
> > cxl_find_root_decoder() can be used. Unfold this function into
> > cxl_endpoint_decoder_initialize() and make the iterator available
> > there.
> I'm not following this description at all. Perhaps this needs
> to wait until you have code that is reusing this to find those
> interleave parameters and similar.

As suggested by Dave too, I will move that along with some other
patches out of this rework and cleanup series. The motivation of the
changes is better seen then and are part then where they are actually
needed.

-Robert
