Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CD945945;
	Sat, 13 Jul 2024 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720856522; cv=fail; b=PZFHud0qS/N2Js650OhlSJBolXAZ4sRIMy1K4e3Y9VwrUxZiJQB+BCC/DOAP9dbgnCBG8u+2jROqscZcU3yIQZZVAL7PMAnjBOAB8ujBMo/ddD6Uz+cT9oYGgf/kfCYYOuJuE/4tNWmTedZWs4ZKvTwigNm5qO+u9H/yWpNDkTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720856522; c=relaxed/simple;
	bh=bEZmwaq4UKj7ZwJGI9eye5beIViaFiQXdxh96NbgUjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZXcA+urlLM2eTQQkNQPytTBQdhtUsOj39ii7tF1Pv3XOZdSbKvkuyxslJSX+DHuW4DeGet2LfBh2bi+qZOk/lZNnpuUCjcf89gsPbu3XRN1nOwoiYJMV7zQ/Rtq+SPwEqTszNvE0exvRy2y001QFDup4nQGin3vGzAYYSpC8z9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PnABQ/G0; arc=fail smtp.client-ip=40.107.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PnABQ/G0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdDPouigtL8kb5OcuP6j7ubB3wLLNbmO9R+cmf8EElE/NGgBPo8RQPJugp2J+niFjkKhCCnE4OCUC+5B4p6WHv6a1+XawKuc6MPvvKoQEdvLZyHryLu/smzgxUXpmU6uwBN1HmVFuqRpljIXNxU77bDK/Wed3/Q6momQrUJiPfgoTBgwGJWFFxBVuVDyiO7hGkXzkrpXDuPq4sQKESHywz99t7At5+nrRTA7GCU3p1seADz9P/Wx0cZ0jV00/iOOjLUl7FTpNTq2kHEPPYY/ujWP3f9uMlo570rI9z+YNY/Z4yTiBgXKW56NhVyUNi6jrsRiehzIxHOg9TAswoXJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7gBAdi3YseLNj+omLDCEu19SzX1LeD0sbp5YqR3Ij8=;
 b=iGs1RX/oB8OwoeiVcrJ2Aq3DpDhJNw1rdWbnymDje+vvALHzUitPXWXhFfXT8NpFse/1+JYYcIYMOv1AJbjPydaD3TPjj9Aut9iK1iz1LpPsB4wocteXPLmbJykaZOBb6p7g6DXNILSCKpm7NHIzinZb6qzdQBHc3zRGCDmdzToCtae760kg2hwmb2PcDdFuidC96AnPSTQbhWnkrwsOycC3y/uH13WyP2H3WMSn8dhMU3GbkNohX0pFoIAZyCTzsjZJdDDaQ2PmufWXPNfqAng/bJNRfcheE3U8OABH2XJFxWmR0cfwxlGPxa+tcnv8XZohVkMzxIBpBMMY4gEvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7gBAdi3YseLNj+omLDCEu19SzX1LeD0sbp5YqR3Ij8=;
 b=PnABQ/G0IT7guPZwWBGNmgM37rDP0SLzXZKsGcrK0xKGPfyy7QFLTB0xmsSCzCFBKnNddWVGlKOAetdyvrEKtMqzlfipNkB5C0g8Qv3ZAH+MxIGikjko/P5DzmxU94zpkjh7hckpsZOr1OVt1gI4GOLm2inky7wqivrccn5OWC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Sat, 13 Jul
 2024 07:41:58 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.7762.016; Sat, 13 Jul 2024
 07:41:58 +0000
Date: Sat, 13 Jul 2024 09:41:54 +0200
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] cxl/acpi: Add platform flag for HPA address
 translation
Message-ID: <ZpIvwsu39jC3r0Ns@rric.localdomain>
References: <20240701174754.967954-1-rrichter@amd.com>
 <20240701174754.967954-4-rrichter@amd.com>
 <669086821f136_5fffa29473@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <669086821f136_5fffa29473@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: FR0P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::6) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d6f033b-931d-44a8-7a00-08dca30f46a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0FCDaDB6dM0twOASZkao8lnnWwlXsrAdXvncG9m3MaGIAj1cpOE7U96ps3go?=
 =?us-ascii?Q?SaikYMxblNPVe1km0QPNuJNam6aE3K4U1KebnPPldNLmaTRuuzQlrfcL10H4?=
 =?us-ascii?Q?FFKy7eMU7VS3sSSNhReXVlDrnFf7QfINxvPdJaBZ9sWBvXC1S/Gpcgh71PBN?=
 =?us-ascii?Q?u2US2d36b2jO5QtmvgP9QtHO7D0zIR3/8lrwf+AijdrRmGXiyd0Tf8ajmSIL?=
 =?us-ascii?Q?gwdSXU86gfwplrQ9nX+5kzKHBIzNfQkPHnacUw5PU6OFs0zc3+cJxe7g53Xm?=
 =?us-ascii?Q?xBe1RAo/OHSN5BKmHLN6bjkSS9UdtySIZ7OsX183yLe9GVvXpAHZtF/0OXLl?=
 =?us-ascii?Q?xZVqxOFcIvzMBaryOpmF6w9R124IW4uLRcKv+hO61mGUQyUSquJKbogesTIr?=
 =?us-ascii?Q?RST8zbUCse5FukTCA0UcRtp97B6O9m6jpCgIl+Ifs6gOg1MIYa+kr3ry9S7Q?=
 =?us-ascii?Q?2itHrFg8WDwi1IPBQKBq37pPDzycboBrpBhpJyZCqakl33VtrrhzEzmUXRSY?=
 =?us-ascii?Q?ERhKy/Y3UrXfwjPYdpcmNM0Xa+C/EQ99zIHAhBKCfPoM6Gc2lnHw6Ha5cppZ?=
 =?us-ascii?Q?6fCDapoCnAV4nPJufXEZAveqQG2x1d2fb+63Hj3zsXHA58sDaLVFw3wJb0ga?=
 =?us-ascii?Q?0wrabiGXxiEm77dufNE2TNakfmUaCmEc869fgukp/xODi85eyYyuRJOV0XrH?=
 =?us-ascii?Q?hyfQIohvo2OLZ1IMAe7dPubugvLCycxqdmdqtvuzvyqOPrd9cJC5X5CKx7oq?=
 =?us-ascii?Q?WftLHHyukd8iQVHez8ZNA3DCZx8irN+e8o4+yr1r4lSix1GL+/fclCcFZhjj?=
 =?us-ascii?Q?YRzMf56gyloS1F5i2ViwJEqp3mqJAGNgcuagd3yxcXSkKqHZVqWwJK/2KbiT?=
 =?us-ascii?Q?xNIqgstA5lZQ2Za2Le/zvdeiJL+7Qvqk4lTnwJB5stIDReT+H2eQqr3fVK35?=
 =?us-ascii?Q?Os3Db1sDOLMND0NPk1EtqNA3zrxzIsfvHr3MzpuZmnNoVlBIk7sQlp7fQF2v?=
 =?us-ascii?Q?l2fu9wqUHM6jSZCQ6obYE8HRc22fMRPaodWfOL/xNPEm091JmZ5716z3+Jax?=
 =?us-ascii?Q?vghoZLGB7ug4iWzrsVW5uIVQZpSHXfxJc4ODmFDR/7/Wk81uilfJPIPm82F1?=
 =?us-ascii?Q?OBv4qwu+Yt/DoMyXX7sD1b2+mr+tXAiDO1eIWrnSgx5pc0RkOAAVqdob9ccE?=
 =?us-ascii?Q?odYZRfxOWsAVJvuLYvAuz9BrgFAlAXyBPC+K5AhEGV5HlDU5nqDZm9WbndbP?=
 =?us-ascii?Q?zjNnwt7FSqi1Z2G+YgIIjJxijYy0IK+YGUVDglMFbRij5HbCuu4MYECfxTrN?=
 =?us-ascii?Q?OQYwj9dZO0saZNoym3iKVJSkA6XEQaOkJDHiBHMVRWXJIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rJYMbF0hKdNPK/1pTjDjc1gRQTKW0VrPnUXSp6pX5gsx5DRNggKcw7M+JO3z?=
 =?us-ascii?Q?NtK76Wbds9dZygn9aDFTDdDfscpHBgW8nUtc/tYeROUJ70mWNWay1RpqqLO3?=
 =?us-ascii?Q?Qkb0OeDxQ30izvx35BBvdbyUnE+cZ4SrUExpeWtXe71ErceJzoVRoBOqEvKP?=
 =?us-ascii?Q?MbxDpDthqFGReVh89uaqDUj1OnJGGndvapFsAjS4GqugXmXbE4KDZtYzNmYZ?=
 =?us-ascii?Q?Vo+6ZlCc6J0E3N4vsVnUBbNQqa+CtZyj3/3B5jk8tVHgcFH8dui6UlvdWEGM?=
 =?us-ascii?Q?WjhdYsXlFykk2mUmLLMNoM2vpfCLlHrD1g/+DuAAQvl8Szfizqup+GkjYVcv?=
 =?us-ascii?Q?JNA1rZcwSNbIOWkXUQyAUrMCrihSBOjcVH6agJo9U4ipMiqhBb3Pga4Yz75i?=
 =?us-ascii?Q?1lLQKxZmhXIccUijWXyj038F9Q/iNdkam3vTWbPO9zH1z+FVYP/WYizgc5uy?=
 =?us-ascii?Q?UvN0xOyWSn7TXhQJox1qgExnNvPZA4Svkt5w/P9B7CTqPa8rUEQEXEiotdaV?=
 =?us-ascii?Q?wgi5tv/mfBWPmiXsjD+P+quIH/CszwFUT3GXq1WETuPn7bf0NNLWvQK96cJc?=
 =?us-ascii?Q?DeFaaJoHxhXhrXYQ3nrSXCn+XlZ3hK1fpGO6toCkRT2R0DFksppgbyn1edFc?=
 =?us-ascii?Q?PsylmGqS6h9heb38kQZkgcwLpMQio5BCEqvj2Zg0ufAvKa2zZqbM52KNXTA1?=
 =?us-ascii?Q?qpRYqIGuDQpHMRKRu+espg0wa362fMAM9JUELOrP7SRPJlz14QMGr/vtDVhd?=
 =?us-ascii?Q?pYTOc2I5hlyXkDme6Gfm1WUJD7JoVYJF5SLT/eJrJSqkBfugzQwU8SrYyMdX?=
 =?us-ascii?Q?vdTXA6Y4XbtxyaMje4AHdhFpSp+Iyh6OqzSyaLWlcWVBQHQhLJ0HPMhW9tzO?=
 =?us-ascii?Q?VPq1abqpD0q0gQ+puGloTSA+3LEuv+wTVH98AYUsxSLhdqSEh4M6hD8koDN6?=
 =?us-ascii?Q?ioKfpBQmYcLE0fNGrFLW5F7l4ZjQySNH/v2b+f85STRpZ0ayH/VWEuYuLTIo?=
 =?us-ascii?Q?UnKOfHJTJhZJZgwakYBegqMKmXEfNqvw05wYVzMc71+oQnsHLjVO5BaF78NB?=
 =?us-ascii?Q?S9y8OStG9ih+DRCOYa48XpAb/6pIzH9DwEleiskivV8zP16GcEOAofK3aWs1?=
 =?us-ascii?Q?8NnjR2QcgwyFT/kEBLFaIv5Un0VoDS3tVZ1pGD1L0Jszr8BduPsm7br0Ixp4?=
 =?us-ascii?Q?73ScDb7J4H56+o0pfg0xJIbPEIJMG5eS4LLxieppDcJhW36fpdhoZtu3WiNa?=
 =?us-ascii?Q?5nkFI6oBC/+BJl3ApAVSY3QTA6YoBFx1PEFovPQhLrHqtCfzl7VzGUJLXOU3?=
 =?us-ascii?Q?QfDaAyoSfW0xjGNhn+Dt3Dup2fPME3L01BQpiXJ9ZWuczkXk99ltq6q4Rp9x?=
 =?us-ascii?Q?fJ/XnZ9qC/vj7mJnW58cRhuyG3dMJ5BXw7FTECmApQu1UTTK6NvkcFh21Kkz?=
 =?us-ascii?Q?8kswL9KCHXd8k+MG8uGWfGfOeA0eCpDO//6ubO1oyQEBdQGtHg63s279ZP+o?=
 =?us-ascii?Q?jXK2GdASfioVXTCzw/5GxlKGmesvu05akg1sfxIj9CfnsL6riSTv7D8MQoF3?=
 =?us-ascii?Q?kDRqVnkoaRpduIIyzhABrDuViLBozIvO0bXwfJ3f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6f033b-931d-44a8-7a00-08dca30f46a2
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2024 07:41:58.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eu6dgspm7ey+FHrlUQ9IwATOgnNBUv9Zq8KdEWPT3z4WRf57QNzW1oPZndxIK8sA2Wl5HH9m+fZ26qPX7bekdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244

On 11.07.24 18:27:30, Dan Williams wrote:
> Robert Richter wrote:
> > Adding an early check to detect platform specifics to (later) enable
> > HPA address translation. The cxl_root structure is used to store that
> > information.
> > 
> > Note: The platform check will be added later when enabling address
> > translation.
> 
> It feels odd to have a flag at the root for this because the translation
> is at the host-bridge level, right?
> 
> I was more thinking of a solution that does:
> 
> spa = cxld_hpa_to_spa(cxld);
> 
> ...and then internal to that the code walks the port hierarchy from it's
> host port to the host bridge. Then does something like
> 
> hb->hpa_to_spa(hb, hpa)
> 
> Where @hb is:
> 
> struct cxl_hb {
> 	struct cxl_port port;
> 	u64 (*hpa_to_spa)(struct cxl_hb *, u64);
> }

Ok, will consider that for the rework.

-Robert
