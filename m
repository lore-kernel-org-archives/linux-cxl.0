Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255A92F90D5;
	Fri, 14 Nov 2025 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111359; cv=fail; b=gkEUWNRzBBrhhHC478eyO+DzF5dxwd167bcp7Ul3szbmIer0a+vztFMaoa8cAINrOGnUwajDyhh14O7e2GCycyn9vQlK2OUywqqYNIOoFP7wss5OOAWAx+1dXxebql+8H8kFpusHS8zO5bAkjRo5D7dydctvW23l17GLWxCZZNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111359; c=relaxed/simple;
	bh=wwjUvnOLRYsxFA+iSPDusf9MdMN/BUzloERUf1VJ1Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RQzQCEDJtj8jSMK2ZnWxJ02SCMOl8x/UqXf4wVj8xUX05eWY3q1crluXjhWrw5mzzJVx8awveP42I8NANSsrd5NqpBSGpuEg/di5UC+dJ+i6Ij+CvHx7gvWcJ8YKWGI+ib3nL9eD2WLptRob8WERJ71kOLb9Qt3RhtieZjhQVZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ivdqghBb; arc=fail smtp.client-ip=52.101.62.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ivdqghBb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qm2zUxGOeHp+pzl8Puw1zfpONdAed8qs7G3jz6VrchDtIf5sUVAm3uUF1aBBXFGuuLv6goAP+DBuiIQg9RE9B04H1jtlmLgSEprHiAGB/FG1NR5uStudtimONFH3r564RON643erffhwOyJq6QGTIqB5DspPa2VW5OG74msEATcJOeKBmcfCB2vvu4H9NpGF8UmaBIedixIwGyjDTtGi+tYU34YEXXBp6TnbxXSbSprH8wBahK/a3qyHn6NOpK6sl9D/4wFWDvf/QphfqUVbyC+c6h92joHxTiH+8nnG2jidRjCmUIncLx1bDhh91YqT6g7+Q9M/fTupaVaHupzb5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RapQV0MjsRaY0ozpHAa5Mm3bKhI3da9CPhgfqHtJhE0=;
 b=FHlLF8QwaAaVDgNtgKnwJUPdHov/Vkx9zIdRIV11OA6pieAe4lNceTaKA6Q8wnlRc+hh3laW7KHlAjf5EXP6aSngHLe6jMY7xyz2kqJcv2XjS6OWw/qjaAR7hhmdUw2EBhITV7iOBIzs+TmAtnfxo0/OyV1yglp7PiqkirELN4WrkLZDEk3SaoFfZFNgFQhcXGBXPumLlwWvwnozmY3nOWAVJWwMaZS1DiozjfVWnZfiiQXrEhR7U1iZVfIowQUEJ2xjCEw2QJQ+gp+Lk1+26+ahkaEyDGzfltZlAgfHle4suPkeKhGhfyFpqhemc9mOBq443tsKPPvxG8OYfNJUYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RapQV0MjsRaY0ozpHAa5Mm3bKhI3da9CPhgfqHtJhE0=;
 b=ivdqghBb56j/vGNEkgonrfRdJ80pg4cOI3lguN0vVGm6pxymBDUuP+Aftb27MTWF1Aqswu9Uxx/L4sFk4SgkrgJmab6J6mqget0+zOHFY2FxjHlFIO0JhSLOEp7X5bXN8akutXANzDora+OZ365kiR7Igx+z1vYWUWZCTYfqZXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 09:09:12 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 09:09:11 +0000
Date: Fri, 14 Nov 2025 10:09:40 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH 0/3] CXL updates for v6.19
Message-ID: <aRbx1EbsGqUDY3Rd@rric.localdomain>
References: <20251112205105.1271726-1-rrichter@amd.com>
 <db9e4d27-057f-4bf1-9d74-008ffeb0dbc8@intel.com>
 <aRW6h127k5Tzns8R@rric.localdomain>
 <f0285498-810f-44aa-8577-e28641e97d56@intel.com>
 <aRYLJmjBsggjzA99@rric.localdomain>
 <a0881237-60e8-4bd9-b990-b72ad29c57aa@intel.com>
 <aRZBOmQH_pVs93T4@rric.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRZBOmQH_pVs93T4@rric.localdomain>
X-ClientProxiedBy: FR4P281CA0379.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::11) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA0PR12MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: 00966116-2fc3-4470-d400-08de235d79e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Jauzr4AgeMeEwKoW/o51txstY7bk/JJHIeSlhV8fdYo7NKO21/d8G45y+nZ?=
 =?us-ascii?Q?zaLEaXMMxVdrzXk5cCXyWJNvGzUAl1yVDwMkUkX7W7qO+n95/mKC/WiskHtk?=
 =?us-ascii?Q?sUr2PdWVi7CX8Qufa5JE3WOH37JQAHXZp4DKjuNCFcK5Qy+F5m5qprOde4oY?=
 =?us-ascii?Q?IVHerRIw0OIEhCAUoZzdJIufGuSPiatasOLBcj6E0VAf54lJXbfDBRZVGR+O?=
 =?us-ascii?Q?JlqItYgRKKbrEI6B8I826dNeK8X4S4ieDj2fRCDiD5CIHzS1e7JHLVCuAmXk?=
 =?us-ascii?Q?63Ud/EMfOEHrTDntY+QuuRJwq3zN5A30hz5bk/TJUbNP1fYaF9w9BAgDuPYk?=
 =?us-ascii?Q?Dpe2JuRSOhOowVs58rAVF5bES0hhxqzKNqClS1oVzzQFXsR/hfx2AxVv0lhu?=
 =?us-ascii?Q?Psodd1oa0doHDAL83pK4mwIfwoaIMHbsW84BGsVbkKNLJ3ie51yHlupJZpWJ?=
 =?us-ascii?Q?hVui3ZbF5loHJyv4xqRdMTrGqIvpXYxyVQZXIbvAoBlkFy+pP6f+aMT/Kw8N?=
 =?us-ascii?Q?2b5nlrgjMbkKjfEpibHfpyr4Xz6gEcsnxx/NxQHCb3MYXJvkbIJXL/f9GXXz?=
 =?us-ascii?Q?DI3WSWqHRhVAoSl4ROql+zKk6pgCyoFXDEBesAxNujnTLNvWG3EVdGg3Mr0D?=
 =?us-ascii?Q?bZCbBHjO95jErle3VQ3XJ5jgVxbv/qiNfuHMHMUVXu8QnPjmAU3X9XFmwcQ9?=
 =?us-ascii?Q?GqoFsehtlmV8yfqxl8IDvfd01qEOPSFDRulb9wbZhUs7q0/3Xc5huLcFM51w?=
 =?us-ascii?Q?6gqEs3QBpgKzqS3R9bgPhD62KlBpekDh9kFCXwXpQ6vrgd76J/YEN4bGTfd7?=
 =?us-ascii?Q?NxXo7ZANPRvc/pCFhS4OLirSl99/Y0/j7a4guoCyVGu/e6kGDUpW+rvf2pF1?=
 =?us-ascii?Q?LcEphFT3OAbB/sNCPC8KwMMZC900YJTaNySvc0CkH58/DiH+kgfGOHGH+wjN?=
 =?us-ascii?Q?LZlmh3hbuqp+I2kNclCNUZ9ffcfbSeC1j9O7M+TMBGYAOqd1t85ixrcBMHHj?=
 =?us-ascii?Q?IbFUEe+wznBNuIeQhus8duvRFpU8sKV4FZc1wpRy4M+kukrw20mTQS9e+bgK?=
 =?us-ascii?Q?XyWpUhYL5oYb8NdQwDpmQACnFl1R4eY0Xg+Rq8SedtfkAlAyBe56YlnK0P/I?=
 =?us-ascii?Q?UlgyN6KD6Y/VK3JA0+rWZVDZtR1bOa5uLxLirED2kfxfA+pDcLP0vgX6ctCT?=
 =?us-ascii?Q?fsH+tSh6X0HFDtdIO99oR+G5WxqHIoUUaOOoWXxfPN+ff/JKx3EMhFKj2OqW?=
 =?us-ascii?Q?qCp+QabSSctkBoiqKWNExu3gi0uobtoGlJ+KNeSfkzpMtc9C9KZy7B9bgP2o?=
 =?us-ascii?Q?P6aQ108Tssd8Ma9RvQCkVhiw/kMhn3PHbXfXDM92YodMqlRGWg3q6zps7elF?=
 =?us-ascii?Q?d7kigRi+4qbw3qSqQVGNSmtrk6J3t/VtCvvfQWXRPrQO/ZHrt1FGHoaGAOhU?=
 =?us-ascii?Q?NqadcWUkSQ89OJwq5PmVOZ81K/Ucmxfw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A2gzbP3S40vol9rlYLnWMvvRDybBzxjTYRZHJvDp2spviuaHPsV/MslprW6V?=
 =?us-ascii?Q?X1JaH9G3N8N3j3LvsefzTW9prbh3q1CgX9DAQrLJD+0qG5nAUVOibDQwYbQx?=
 =?us-ascii?Q?cUjyjEs9h9pesKEHYaWJvH4c9mpBqKtI1/7mZsCGC3gwg2k9Gwhmd2UcFcgv?=
 =?us-ascii?Q?Js/naiTm6i91rtk3d/dgkmx6MX1/XZM0eXIcDgIJBHFu1BnlDSuk3Ntqq+8B?=
 =?us-ascii?Q?xXMXQbVw2ZdehtmjxVl29QfL9l8AH733WbVo7NUyr/0AC8HT6kzeKKhefByz?=
 =?us-ascii?Q?LQisCng26LVTKE+4xscSeQagbccMsDKjkjzcHEZAPhK72X7xz8pUqZGgc6oQ?=
 =?us-ascii?Q?QU0l3IHkoPpLMfu7+LerD7G/OLs0JF1dEswSF0IX7xpYo9NJ8b4Iswlrumqt?=
 =?us-ascii?Q?PpzU9R4/0H/hEZn57S5kRz4vZ1lZycPCA9duZMYGft847ZK8MJEl7vgPD8gu?=
 =?us-ascii?Q?V7r6uM3WX0F0QXmcKdRlrYFvRTcwmvz2KgbChh0PBlOJRPuLRwuZI9d1+87K?=
 =?us-ascii?Q?5mTNNS6Q1FPAJwi7SeKf2TTtj3EXRUA8moIiEgSPTRYEw8iIYQdS+P4sJcip?=
 =?us-ascii?Q?97H76Q8aWIk+GoaRvyrm1Wy+PNpGCDUBw2kzg/bXncMHErO5mWDIUSKgucbw?=
 =?us-ascii?Q?sOF6ishaGeFW4ya8ag9PhambEE6jDPjF4by1HIhhBjyTMOClbdg8vcQ5mJz2?=
 =?us-ascii?Q?hs+EWJxjHOp6CIjDgw8F3jSOV4aNoLZ5L0LowYu8yfgpDV6+RFkm9TKjXu5c?=
 =?us-ascii?Q?QBq3zR5iNK6AHbXa58U470PflHpmdNsbTtFrLlCMJPR5NonhOdIXc0Rvjip4?=
 =?us-ascii?Q?v2wXA/8oydCildn11De7pbNLHEOAAjzQdSipf9bGaygBnyk7VOWu1gGJOI1M?=
 =?us-ascii?Q?nqQarwuZDBEBJLc//3jhqGyYhZvQsf4+l6bcLPMrPGltIZ4Crkh0o3nSg/qd?=
 =?us-ascii?Q?oEChYMhJUo4nTNWTVOyKG2Ux5SmcrrCxXmKv+Zvd/jgVJwQTt3r0EOZOnW2D?=
 =?us-ascii?Q?xTYOSNrJBo8fQMLVKPb8YFWbdVC9tjVVHT6gPYKdzwUdS+9MDR7ZhSF+xfpg?=
 =?us-ascii?Q?5HrJCeaFp36PGGeuVJStGmCx3GXaw2HrkX5SR5+oxuAKzTm75GbyrhRqbcAB?=
 =?us-ascii?Q?2WMGGU6ZdK7RDhScVsdgbz1/rfM3t4PNfsBmBBTTd9DbXiRBwFU22xjOaDoG?=
 =?us-ascii?Q?2ywSGki9Sx6i3KYdbGZEpH2X17SJ8UOymUdij33R6doermnpHbNZj9Q4Xc3i?=
 =?us-ascii?Q?Tgu7iUM8+JMkDvZeeo9rZFFKdslHkkzw1A2MaTvHThzqsp/7HFrYaVa5YtgZ?=
 =?us-ascii?Q?cjhRR8qzDBQTo87K6P92oFk8ac7KMBcHNBWqR8udZ+ZKeLg0uGOqZKAa0msf?=
 =?us-ascii?Q?HXIqJKEBs10ykj1xmKLZ8b6IuOs78mqQTputxdTsbcCxnHSP6Y3J9v/cfO/o?=
 =?us-ascii?Q?a2EiNnsAObzbYOCvVjOkmta79gbfZa9j+X47K9kz+SP9DvtIbvSBooEwhtJb?=
 =?us-ascii?Q?AsVreLu82Vt4UwqxZAqoSQudrFs0QLdHjLELKVQgSC08CGsZC094C7I1VtQw?=
 =?us-ascii?Q?xvcCnNbVQoDfpJe5daijffNTmgv0E7PSSQhnpD3r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00966116-2fc3-4470-d400-08de235d79e7
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 09:09:11.8985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j64VWCRaelN+CENUpMv1sX2e3ZQyVid3Iw7XGSuSEWPaBmSYt07vWKw418Wrf5Rev4SkOkAY7yXvMzuTXslz5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864

On 13.11.25 21:36:16, Robert Richter wrote:
> On 13.11.25 13:10:56, Dave Jiang wrote:
> > On 11/13/25 9:45 AM, Robert Richter wrote:

> > So currently we want to apply the 3 patches ahead of time right? Can
> > you 1. post the series against 6.18-rc5, 2. provide a public branch
> > (github or kernel.org) that merged this branch with cxl/next (given
> > there are expected complications) that I can reference? That's
> > really my preference.
> 
> Ok, thanks.

I sent you a delta patch as I don't have a public git tree at hand
right now.

-Robert
