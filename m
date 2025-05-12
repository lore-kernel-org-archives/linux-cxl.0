Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532222332B;
	Mon, 12 May 2025 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747067232; cv=fail; b=kRroB3BtuRl4EXepwBrf4HFmhvQPJD6CxGaKC1kQlcoqCoItgSib5vep3r3vJYvlFb84ChehUtaZKva9Zb5dv+DDZE5GURQOdRi/MtMs2ddxoBcrMsRYPvoXndeoaKxOfRn7JG8SMd9bXMgk8Kq8IbQlBeJimcsbG5wDYXhFhDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747067232; c=relaxed/simple;
	bh=dXzl2lHfU/fZVBUxEau3kLLLVRDklCmoB3bUyhJgAYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yhn7/aAniKkpcVcoJB29zAmAKqKnIvjm3PpyQBdfL+F23zuFkf63wQ7SBX+Fb0SBQX7wkT1Y71jrkaFHKvI4cDdIb74ELjfUoOW1mDmMxrdZpGZVthlfHO5PcgPT6JcVjJlfKqGqbhOamnIzdIdI3FTOnLnha6IXIidCjhJNTWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fjm1ydz3; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fjm1ydz3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6MlVXyDAQwYV+IHtiegKyFubmfKE5LCUp20OQp27dk5Wi9d5dr1XQRS5gBhryiHM0XsK4mSDot3nSC1pmwIhheVUkifuDt41EnVgPJtZZt46LQayNFprDeCM68uTIgyCloRdZGkPkqFu+naimgfpiBwV5XzQjcJNABc7eqb0UzZ4IzYShprPI1AlE5Rw1If/flCSW4mndF+YlqcIyslRvi3VPjo+jiecVd7IdjEPflMWB29Z4ajdpU/Q+Tl/OMflEiu4x+Djz+gD9f3HF+tWv7D9QSsergJqsQj+tQfYtzbzPslU9uCtbAnlykcYkE/jGODpAB/hdNyzqiReP78/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7q3Vcq6jfHL2ih0DtqV9MT6m1S4HM79li4Yo5GKMKEw=;
 b=H2sL9+GeT9yirRVbd/g0tGerSlj4GZ6KsWWkuYG8FCqhDx7xNY2scNP8A3U7GTYpzhisXH7VmB3YGGyFgQ2M+bfKviXVGGck+Eq+jeM2IMPWEksEkIkmwlckMlcOhPzy7OIfIX9FM4OCNFtdD9jpTixRguNVvsVvNxv/L73J4sTXsNLVwfBhtMGn1TL9TmzvA1ekUXq9JAPqTcTKkzEnDY+qQyIRg2+TQbVsSRxe9VZ4Y3bPEhIw/LreQnKEft3Ebw9wpN+pix9HhJ0iq6shcVumoZ1ltqkeCQhMmtlmKeNymHj+c2Zzh/iBISM1ugOdRgCNJBA7wKXxGPZ0x7Cdqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7q3Vcq6jfHL2ih0DtqV9MT6m1S4HM79li4Yo5GKMKEw=;
 b=fjm1ydz31PQB+3rGZz1IPFtsidSPvk/geKIalbmtfkOmtoedebe8kN1U3VTtewT2YvwYnxvk5OjPKpXxzW1vwymFpFEpz3vJass0cY2AWzzUNSKo/mtqSDbvo5cPwkGobGrXNeX7ex4ITAUgkpxbQAhl7TJla0WSfB6Pfo9UujY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 16:27:08 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 16:27:08 +0000
Date: Mon, 12 May 2025 18:27:02 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v6 00/14] cxl: Address translation support, part 1:
 Cleanups and refactoring
Message-ID: <aCIhVj4c2CH_1Oqg@rric.localdomain>
References: <20250509150700.2817697-1-rrichter@amd.com>
 <14b64c8d-a5fc-42eb-8160-590c17bbbd99@intel.com>
 <3df32c03-8e83-462d-ae3c-ac0a76912786@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3df32c03-8e83-462d-ae3c-ac0a76912786@intel.com>
X-ClientProxiedBy: FR4P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::10) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS7PR12MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e8fa08-b9af-49cd-ca36-08dd9171d6e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EZXczo6Qwvgjey34w4y7kfp7K2FnqyDZ5/h0SyQ4dwaCK819szl+fStuB3t7?=
 =?us-ascii?Q?DGEN9+Uv65YGn8n0Y5tKN+jF34ElSWT4JzOHylYi30ozDWxXT7ADducaktp8?=
 =?us-ascii?Q?WipVJrMDW6YnPFsdMQlGMNXlffDWT+sPI6BhtqfzlsNKrS+qMGlFkRFhlYZj?=
 =?us-ascii?Q?3USJAKs20CqpTUhORO/Y5Rwf+e20SoZ/+rasetWOr9aCiXqMF5puS+GgwUc2?=
 =?us-ascii?Q?8+QdXzbJ2JAv3T/9YAFf5OZWQi/y+dqv2OgA53UxKt1H7/iNkp8CjivDGk5i?=
 =?us-ascii?Q?d0oTJj43bCbLgb4Sip9CT7m3cFzqMkinwxOMBCWEKZbDGGvAjJSsSOyG++SE?=
 =?us-ascii?Q?6DPXBywJigNyF1Gt4t3zgehLG+tOEH2IUAlct8knpBCRqv5CwLuxTh7yCU6i?=
 =?us-ascii?Q?hXAI1M5gNXfkvaNA2eSB3yhVIagRe8mJlK8Il1oFL85cFGfUU19n69RmOTN0?=
 =?us-ascii?Q?e9iqr09nRYhHPVx70pVkDDXkuQE9kDYgZhyx9V5DJ704VrFfSB64v3+NpohH?=
 =?us-ascii?Q?MID7Q/x4B5PfCUzngPgP0Ew0WY2jeZs8OB/7SUdsrJvHg0itzDTrBtGZm0A0?=
 =?us-ascii?Q?1M6n8sN4pv2VEyh6JG26bPtf+rfZS4gYCL6kMhZNg6w7IjHrHm5XX0qTqaK9?=
 =?us-ascii?Q?x5cfkhchu1vLrAmB/YBJd6aGPie86H0PSQqZoGKCaZCKfvX/rVUHcGsegEIK?=
 =?us-ascii?Q?tXimo7VmxTy0MMAEnJNdiY49VXMn7cB5PKICdSh7uHbYpw19Vb7PhC3MJQbG?=
 =?us-ascii?Q?2lM2Y6LxsVYsA4KLUCk1+RLBEWA9eVDt5fC01Vh0qadHRxn5NMex7lVvWW7l?=
 =?us-ascii?Q?k9fQGMl8qfLcWEJBD5xo3popnhonSaX0GBrMi7+nEHo4GlUcWSDE+zCLEGJx?=
 =?us-ascii?Q?7hj7hHw+vrFnmEoGOv89ROssSeQ/99Kyb8tqfOLzdIfjZS36hOMt4pExl+KG?=
 =?us-ascii?Q?sCdRdM/ewhkBTf10FxBjYpuhsGnPMvqcySwto/GnlWcjdKQygZwdtV6RiWao?=
 =?us-ascii?Q?tWjAJWv3JYd5KkHLlFtz6BM+dJJ1OkiOIdZFYEO1VCsTaVUGiG14MycivHwt?=
 =?us-ascii?Q?TJHu0v456/x2n0PRYdR28Grtor50KGYiVMFHRnMxZme8UNjBG+2OPY6yMU5x?=
 =?us-ascii?Q?ROfgxwAPDrUGpfVo1zqMoxfDj7zhkkUUbTRddCwu9tUzAWSnyMKkRe4UDx6v?=
 =?us-ascii?Q?xrGprOYWkGBxDD7Tc8rnzxUtMR3MWaFSq+67wMp63uMCjz8aDL22rOcDD5Uz?=
 =?us-ascii?Q?gSbmY5NOSm1N/cayMJtGwD9aqiKz2QrUEZWpHIbvEa4Az8PU7QGPVdYgRswz?=
 =?us-ascii?Q?tTeu8muAGCTRUuyvS9Z32si4MZ9CXiZvEfgswA27QGkOXSeb6VqGA4MCncAh?=
 =?us-ascii?Q?f8/i0TrOT1Am5k3wtNHaNN7W0Sad5CE7ABcjrAp73NQRLdqL7RVOg2t+7r9T?=
 =?us-ascii?Q?q73yqd56T1k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4aM2agc5PIBbmERwD93tROMtiVmsmiUn2e4lBGEQcA6Wmx0mstsWVRB0J6x/?=
 =?us-ascii?Q?9Gu/j3FDAxd6KLLpAyWIxNOUIERTwr/9lr+gp5UeKv3/2l16FcEy0TCPn8Zd?=
 =?us-ascii?Q?aDPQGiaxVvXKoHempim8Mz5Ku/EGPwG6zj4KyuBLdf0QiYNvAUELMbPBuZwI?=
 =?us-ascii?Q?WRQz0BBDFXGv9m3oeVKEa/WV1peXOtQ1kexkfpY/vBAQMPfyGOW9ET86iZkm?=
 =?us-ascii?Q?ciKkD57rhLNYlQgsCPxqaSSVYwyTSNz9HII1XcsBSUcN3/UmXV5tSx7fbRJh?=
 =?us-ascii?Q?i0x+Li4JJDSNFfLLwj3nmG0pa0RzJZ/1H7ShoROMR6h6kTwNoFKfcobWhhXA?=
 =?us-ascii?Q?w33CoaJs5TRTLSzsQBh2MwrazZHbAbfzoMW5IcSkZ3Ug80GY0wursHiANnt7?=
 =?us-ascii?Q?1+P68lVSV0jLAljWFskGFbFCcjw2EiT2ghJfmWrTdMVI3RGugY+mZLmw//x+?=
 =?us-ascii?Q?iXdR7KnvVtb5cqBCl9v4W5u58EtuOjM5sVh00eLG0YG5g7HKJlQxRiI3rvsb?=
 =?us-ascii?Q?Kur9efoNqaxYKPXTDGI6rWtK2jzv6CBXT+MrIQ7PvAd4RaIu8kOxsuh2+fGp?=
 =?us-ascii?Q?/owjvbE0U/ebgUf4WQBRIzOgyjzrmTDs6KiqwKAG3wUf6aGNDSOL0XW1oObH?=
 =?us-ascii?Q?hsLpG7Tpr7d47QAX543nTPfkNXr2i02fHKGTP0aae249tkAk5H7P8Qtm1Z8o?=
 =?us-ascii?Q?x/KyMtt0aowBY8induojyvrcZuLYJpBMTMLkfnhoALtcOXJ3OnL3quVqssd4?=
 =?us-ascii?Q?8+EjmrnAd4CUqg2DyRmrVzBd1dboyEa4Gc5Ni1XeRM/MzAc971jCWJssBZXe?=
 =?us-ascii?Q?x578QL+VWAMKDMJNIkbJOT+q+4t/Mz8cN1IS54Oru8mymPg1VEjFBqjW/MvF?=
 =?us-ascii?Q?HgDXWkQEQDE0HBW6u9n6uNCdxrkxhQ7a9XJNYeRZTUA9hSfsf/kVNWuM5Jbk?=
 =?us-ascii?Q?2EqjCCBzsmeVebZqUPUwWMab4cESUELRBuqDHV5NDCRY3+UZWNf7wyLX1SF6?=
 =?us-ascii?Q?9olT5JGFsn5hIzIOAcxyyY4mD+Uh1u3hdpXHs0yXWz3oByFSDFnDm5EjylRK?=
 =?us-ascii?Q?PH7vOfCm6lElmyVJ1jt6vz99+oKqj6HNgJ75fb7mboJLssxCUzJWzBXucWaP?=
 =?us-ascii?Q?VHXTwMm9eNq4pKT5E8MKURjpspG4CHC+F0XuO+1gDFXbuD4G7wDsuxdAb7uA?=
 =?us-ascii?Q?y1pMolDesm8XzZxYhVMvuWdHu2LTpU1v0BNdcKM0AAe2+FbnI2JnIPVQJgpA?=
 =?us-ascii?Q?QHLmbJa/BYZmgarVJSpIiYkO3wXtbq9ftUIAQ86esZsV/pBXNdZEpCsT0zJ/?=
 =?us-ascii?Q?4wx0lZiZjGCDkSGDc+aKRGfSaAiZEPnXUdPoTpJqr50oZ3blBufhyl18U5WZ?=
 =?us-ascii?Q?gWdFzBTnFtjJnA9DbyJ5avBFnlpRAWw5RJJ4K3tyb+hSKhk6oIkcd12Ag4Ix?=
 =?us-ascii?Q?N3l2ZxC0UXfMxVNvpI7uq+eyLnUylkP8xkSSQ8iIrwf1kxobcoS+D7vmo4br?=
 =?us-ascii?Q?u0vQ8B8KTWnZizRXk1THayKmupfNvH48mlbx8F0RGhezc62aYTNf8QmM9wHH?=
 =?us-ascii?Q?qGnI0EwukO1iUEe6MumiRZ0OTMMxPI0fSmdkVP4q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e8fa08-b9af-49cd-ca36-08dd9171d6e9
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:27:08.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MpMtBvr+EzRYe2BvZf2dt8T02xi/iG54OM2KKAM8Ikshu4SpxQtV4oxI9feslpzhOfv/lXWVjE3G+UyTRYoEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720

On 09.05.25 10:11:43, Dave Jiang wrote:
> On 5/9/25 9:03 AM, Dave Jiang wrote:

> > Applied to cxl/next. Thanks Robert!
> > 
> > 
> Robert,
> I applied Dan's requested changes and also picked up his
> ACK's. Please check cxl/next to make sure everything looks good to
> you. Thanks!

Thank you all for your reviews.

-Robert
