Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462EE1DE896;
	Mon, 10 Feb 2025 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739190919; cv=fail; b=hAacNBDc+Ot2ZC8I0i/4SIMqfTpCDeYlJxuhvTLPUD4l7JBEaAjnu6brJorFTHII/tQ5Vsg3HfdBmI0dmwZ5z3hfEoMgLZIzHE1UURF3Lo2fHAqOcrXBK5YREVzGNbb6EjITOtMGTw9k4QVoWiniUSRCT2zbAjAz7AKxuCDhE7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739190919; c=relaxed/simple;
	bh=KXsBYI8cOfwfQ1MXyC3uEt3T+2GLuNnBkt3PvV+sPRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rVO7oed7V0jS9YrSbzQA9DFA9UJ3dBqAwrlj7orvoNvEswGK4Zkmx/dkeKCu72ak+Wbwt/6WIi/DmeXGSDX/2xayPhX2/l5oiR6YVrrpNrzdFxk1DK1z47DFmPlTA9hsnses9bEx5LxTge2MpzeFWj+dpp58vpZi9qAljZF2Gwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O4wUHMS7; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O4wUHMS7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZO3agfL2flCCfxaxxRxq+sBCy/oyXclRPglDHud5TkOsCmHWyzb0ub6/9PJ0TIIyr//hPiOca80BiqfEOr7entJsNYokil18whhTdLOVQNpvBGLRX/gjDCp2VyzA1bdzquF3bWSXHINTWV24Qjk+mrQNd9v/oYA0aJYElpmOBPIdjnlRqHmu+1qZIlL0gC/1avHTlh5v2yqiLkAxa1FcrC6qnXCMjsLAvvEhV+rlyflqhLICjUc3i6+BZutAdw40dTAWs/fHGJgMYO0Y/faaKiSEil1zTU3gegQAvDTHHTWjFzelBo5mW32rURJHOYP4+d11VGsea7VKBaSxrBkGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Edd7HLpCgFHaiV0R1yHbG9Vwrqnjh62rSV+23kxL6cU=;
 b=dE0Nf7N2ortzQOwInKpCFOS8sj4WeqxiU9xJwMTC26gHrrBE/ryOo6sReVykClt/SaNftWKcDNjAVkIOGWzuCwSjXSU7qENGrJYDME8yCkagj7MgmXfrmK+YPyH4byuPx9xO4yvBveO1QbHhenWxOyyCLnWSsTgoyo2/Q16b86oITE1PvSDZ6dSEOslcGni3lukwWN6p6KQsQAs7TOgsrTTLQG1GNraDICDiBEOPFOaoMzFLyAlMgB10Q5l/NQmJh4ZqeSg1oHU29KFqC5agmh3xTbK9CKoW2G4NsiK5tz9losJk45tOPf1Cs7UfRerwY/dedctuxGU6dReEO8bbKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Edd7HLpCgFHaiV0R1yHbG9Vwrqnjh62rSV+23kxL6cU=;
 b=O4wUHMS7LyWzuz8OAk9U6vW3AVhm4T/YetcvQitIYy+TxyIL6H5IS6JGx0JKFRbziFtPJ3kMad0xObDIzMCEQE6inE6OEbmOHUYmWAeOIp3f5f59c6pjC52J0gAI0bK5JxgmCUkv/zj3nbLVmN50Wdh8W0yAChea28kacU4CA+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Mon, 10 Feb
 2025 12:35:14 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 12:35:14 +0000
Date: Mon, 10 Feb 2025 13:35:08 +0100
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 16/18] cxl/region: Show message on broken target list
Message-ID: <Z6nyfPERAmNb9jFr@rric.localdomain>
References: <20250207153753.418849-1-rrichter@amd.com>
 <20250207153753.418849-17-rrichter@amd.com>
 <Z6aZDYtWoRezYGG0@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6aZDYtWoRezYGG0@aschofie-mobl2.lan>
X-ClientProxiedBy: FR3P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::16) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8f7c5a-70c4-4e24-1ed9-08dd49cf5e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OQ0hCp1yZsEnWYN5D9tqW3jmiz9DGU1d8hThC1RKPayXaxpXW+xFWDKsgVoB?=
 =?us-ascii?Q?QqYdUp4jSo6xGc3La4wCHN9abrg9wn/doolLggTQ68L7I2IMQj8tSVQOIXBF?=
 =?us-ascii?Q?vytGORItXy7GcCM/GibaoPQ7UO4yEdelqQGAB5nmlFc8dE1qpGkmY6l++Ten?=
 =?us-ascii?Q?wi8LRrmLNPvIi0/CJDeciRaZoHSKwb88eKJnk8+xTZwdFzKQiYfwiwDsoq1M?=
 =?us-ascii?Q?HeWkzmuXoNwQMlLgy6fLOEw161HJ2jgUBw3ecGlVLOeq7Y8epuTQMjNJylR+?=
 =?us-ascii?Q?ASovQQljgLWso08f2cl4XkMTqNZVsyAr6NVYHebGKbbL81k1R2h1ErT9+a9b?=
 =?us-ascii?Q?aKgN4gRZK0g1ZJYCsIKGQpLtUlepybSe4ttwvrYrldvzGUtbbtSxle96Bm6m?=
 =?us-ascii?Q?h2dS5zEJGkdy1tTJbeEnEFaX+rYbSZqLaWaHDIxRj6oyDbnFXjpCZn4OcXsU?=
 =?us-ascii?Q?CNJm/ig5XbRW788FkP9McvkFlR2xZf1KSb8Qo/+FbR4HDdI/yzcsPwOoM0FH?=
 =?us-ascii?Q?7584JpHyMiyMo33HK7/GzKnEmeXUEhY7uTzMhzW3Spif6PgsueWH6PHuZ+d/?=
 =?us-ascii?Q?sIWu3Id66KQNL98bR26kxRx+mxMfBdJSWnKMi2tW07kQiv9VMdpvW7zLkzVM?=
 =?us-ascii?Q?F8V9fzyAKoQIK3ZzRkxJsK+AYw9zFSrUTvC6B4JGXbIUgPVdJ4eYV6n6JXD3?=
 =?us-ascii?Q?mY0t46OhYr91hnHBC7xfvtzcpKycRwk3y/AM2VnQAcIPQG6iCsiQ+Glj7Zij?=
 =?us-ascii?Q?LW+61x/1regx1c2XHfeTIKfaHqQ71znGuv00p0rnqj6gufcR9L7Zy8MiT1BG?=
 =?us-ascii?Q?v1pmWAgBI+vogLey4x/p4Xo4DF1jMyrrL87klW3VIVDCG09+2ulGKTpgqjbT?=
 =?us-ascii?Q?sKpqk1xfjM2onXu9G9vfmX6xHD3/o2O9CFwNE451/2VQOmBGKHgRg+DgKGXh?=
 =?us-ascii?Q?yG3UAUo+aaPbgsf4hoj7vtMT01sDofs427j1ZlLnfvN82aA6zRGzhB+ags9+?=
 =?us-ascii?Q?ZFxM4XejWGtgUnPa4lFm8bTVAHDMHruIm70Tpeo3EXAvkuJD5h3m3dXVMIG8?=
 =?us-ascii?Q?Nnw0mrorYmrQjA0ACM5QpYzeL4ztGv6wocROmxPdSGN6kpjSl4sGKt1pd6tT?=
 =?us-ascii?Q?bkTFHupSxj2n4+O+8HyePCZLHbKUopCf6LE3XUWvgBtVurHKoTV6KKrV3YAK?=
 =?us-ascii?Q?uv4RMg0Ier1g9CRc4vCRslpwUKHL2bjshizXFGaBwoxM6jFucRzMAMTt31DV?=
 =?us-ascii?Q?K90PAS64BNn2ooIs7ubXCXcvF0mIruDDhOIJI7D9SLlLIUuAeQNMkx9s0L6W?=
 =?us-ascii?Q?EcPnvcZP7A5vLeHjk1Fo1e6SZpxDQzU+eIEygv92CU8+Dy4/JS4tjn8S7Yg0?=
 =?us-ascii?Q?aS/D7wPsNFQmKVcScoxtw8jxNVIh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LR2mkvtXh7AbpXrhUDn1LKHrO6mMQ8GPvzcuPKY343p91Gjdw/0XAHZn/FsQ?=
 =?us-ascii?Q?YL1W5L5eR2fhLdG/jHT7Fk0hlvaLVUBp7zSHnyibq1uWmm+lXbcA/rNIg+bX?=
 =?us-ascii?Q?EjMe3QLMzGDAGqtQhP5A4q5ofCaOpfXN8xFXc8adj/gkUwtDkT8rhpATX97j?=
 =?us-ascii?Q?Tm6I6Wv1HUR2cWfJQXCXmJ/krEot6F2w4rO724SkB20BLywrtQbs8iSLcc/I?=
 =?us-ascii?Q?kzh4jw4ovgb1P1V3cq1Kh056A7amRj8KHN8Osfe7VnCoN2m0PaaMmQV6jt0r?=
 =?us-ascii?Q?4fe8lnWuyXf//K6Dd7A5tt1N7/TF+vJ+Jt0ymZpPNk+G4C1NnDZqc96sZPL/?=
 =?us-ascii?Q?qwiLVRaFIYAD04RFcoi7k9DMr7R9F7HVWSoEwYWSE470nonezJD/6ICEdERE?=
 =?us-ascii?Q?FCW/IVYv/Y/CNvVihLpzXvoB+UWF/DMyJJISTfK++ZuFcteoV4SJTxPCctPe?=
 =?us-ascii?Q?fWp7wdLRJpy/+I7ZbtX4LMHdcSqVPzUqebFfxS1wMnzqE/WehsT+q47zrq8g?=
 =?us-ascii?Q?04pnwxTk+eVotUl853XfesN1v4vTzraKVciUHFW3SJdyWS/oIDS1+Hp8xhzK?=
 =?us-ascii?Q?6cWg5RIuvz+bIdeSW0qRDyU18sCgJE2UYe86T7QN7LO0aPUlh0Of6I3Zfmvw?=
 =?us-ascii?Q?BaVj5+hC90+aNHFt2dUUTI2dJcmm4nhxsxMMkibYeCNpZO48xP/FxEluiLej?=
 =?us-ascii?Q?9h24Ki6EsNQu3VrT/SgRrSVWeZo1Tt+vhnw7gAULyP5XOQQIcU6oYaEdKDcR?=
 =?us-ascii?Q?gMP+IWDDpbTZKxLeKUottELTI7f+rGSBcJ10OibHDcpTqYwQoEzwwm4QJA0U?=
 =?us-ascii?Q?rQAsiQ+/O6zyPqxwa5CXU4N/GQbYZMSxRVhonr08XEd7aU7uRnxpwqUsyqmR?=
 =?us-ascii?Q?B0x4sXtmsH4P/GF1RPLxA1kdegxkoq4YSnBP880zcUfzTIlmUPmZjb3HJ0lc?=
 =?us-ascii?Q?UQ4kktYGqzVEzazjvsiRHBJBZUOUzwrS/TgcXW//RMIL11BRuaU67h5UEZzb?=
 =?us-ascii?Q?ya5YQnJK9ueWIeVBFWQznyAAtl0go9jnm6gTfrzGpJHngYFgsFBBR0T+Dd73?=
 =?us-ascii?Q?XhCum4YDYwBt7W4OKNvu2Ow2aZPXfdC0xuNET7T7Mg7bovnkyD0OmD8TOusd?=
 =?us-ascii?Q?IwuOHKqn24MseVc6xpWjhZU056UmxwCfLX3yAXuy4BV1vOQzhqVjudF+0uA2?=
 =?us-ascii?Q?kuR0F8vQrcjWpCnyFnw4X6Fsm8O5bPDWjZNdqPi942Q6UtIo26Ukj3DVtSst?=
 =?us-ascii?Q?aCE7kG0zXQ+/1spWOF4i4ynBBaNvrHg77B5Ef01p7JJy1uLRS2sz46bav/56?=
 =?us-ascii?Q?N6k89KaKmFPtmSuH+py32SoK/cWoyeHzJNoXWdM58E/wK1H/iPN/U/q5tKIx?=
 =?us-ascii?Q?RFjjWrpo9xHEwI+rBef6IxMgaXhZRXO+C5VXTtZdyDtASlLeZpTlM75DJ1Ll?=
 =?us-ascii?Q?hhv6zQASch/CQgKGMmQl04x+iaEnd7m3haMhoaYQ45ZfdIbb+uxYCpeVbA1c?=
 =?us-ascii?Q?ws4rxNSH74I1SDqcecmY0Q1TtqcSE/LxTLVeW5PnD/z4LMc5hQsfcs8oOWIx?=
 =?us-ascii?Q?zFGJ1irRK1mLtugkJvX4fgoO3GVRKiJqAFuVj7V6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8f7c5a-70c4-4e24-1ed9-08dd49cf5e44
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 12:35:14.6485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okskavIp8wdIQfxKhFkkhM9bWK49YUiie7OZkEnjGa3iC1gB0Y72B9jvoUw2/hr5XaLVlY2lbE21KJDnfrAb0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509

On 07.02.25 15:36:45, Alison Schofield wrote:
> On Fri, Feb 07, 2025 at 04:37:51PM +0100, Robert Richter wrote:
> > Broken target lists are hard to discover as the driver fails at a
> > later initialization stage. Add an error message for this.
> 
> Hi Richard - There's 3 of these patches in a row, so I'll share
> the common ask here. How about replacing vague 'Show message'
> with type of message like "Add [dev_dbg() | dev_warn() | dev_err()]...
> I think there is one of each flavor.
> 
> For this one, are you able to append here what it looks like
> when there is a broken target list during region creation.
> ie...put in context how this message fits into the full spew.

Yes, will updated the patch descriptions.

-Robert
