Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B2719994F;
	Thu,  6 Feb 2025 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738877030; cv=fail; b=UETWdC2HnhYF6IKsMcJw3av4fmHsDLcmU4x0IblBkRnpFD9Zg68RIDbqGPsqI5h2VVWZTGwloyslSqlwhNwFK92gr/XefPnDkjxXldrBfjV1jSbHXm03RShm/oASYgBWFp3bnPzjY427ZhyAtTIq7uWL1RpAV+ybBObTliyXQiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738877030; c=relaxed/simple;
	bh=gCuiZ5/Y/3JNZ0aLimpoueGwcWw4URorYt/XR4aUTh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q2j2Bfx63I4JMaRov34gOa5vRfXN8X9hCdrpxX8hW85ZgTjPHaQ8zFvsgNVlzAIfQk9+U5s3mKvuOQV1fBEJ6n0Qd6betjJMN30+mI7F8i76qfdok5jHUsBU5mnq3dAo9rz+7Ciy1osw9iY3mD4dkGI+eoJb/TgZGNZwt8X9uXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JXowtN0S; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JXowtN0S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPxEo8bBXWnE+k/vYOwTRySjhVvL/H1En5szLl22mzOYIck90rtnZ2U2TZGLlQ1yOIurlk0whBIsmGkv1Wc4roNQ5VIjozLvX6CiAbc0ILEJqymwSNgGRnLhm+64G/iofbgBzi5OJvjInFd6D9jfumh9SUJ0IqxH3gfOXQIsqZ0Ouo9mvMIcW0WdiwI8+yXz5qlSIBb9mQ35PAzZDHP22lWM0FfblBjqRacpnslPoNgboalIkLH7jheRpTHUEP89VgsCL24w6Toedb38r8ahS3j/X2g7ejcixF00biRbEOZXJ7ZZkfoyzvHO9qCp2gqoqpTBdCeqRIyn9PPyzWKfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XEkjM+bXh72cpwcf/TgovzvYH9Gsfm+RC8ivlTGDNo=;
 b=K1ZHTlhjD79VfZCXdsqKagwvLcXupE5zRcojy4UOf2R3lIkpoN872Ip6ekah+TwBn+aw13Ojh47T9sSoWP1lWBWFYE32iQV/K2TQkUtlNBbjB8Bdn6h0ZuzplQLSY9WaVwmUEGZg06XASbg74HtGTdEXpGrsL1vv6Xa+hokix+jvze4MaLS3rXW1dxjMmWznZQaKFq4MQ3eDyDLQStYU+W6agdQGUgVqBP7xp32kvVdUO5LKhJ9uUkfocg5strd6+8X4UzLES51vP0R/RnnthLwerjr6UP5qHMdtVn0NccOY8QaMwjrMmNlOorRL+lGoJxxkAVUWE8cFkOM3z+XbTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XEkjM+bXh72cpwcf/TgovzvYH9Gsfm+RC8ivlTGDNo=;
 b=JXowtN0SonWQ7i155v/aGpD85lozLhKonPXLqtEfFMa6L9VFWwMcinYg0W6eiEp82cj89rZVLo/SI8OXe5v+2ZREARovRWqK8oMgu1PFL84VNn6g1CeKHGYQj8CyJNdEdHTNuMDHWaBfqmV51eV/agzDi4Sr6IUznGCbypWPl7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CH3PR12MB7498.namprd12.prod.outlook.com (2603:10b6:610:143::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 21:23:46 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 21:23:46 +0000
Date: Thu, 6 Feb 2025 22:23:40 +0100
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
Subject: Re: [PATCH v1 28/29] cxl/region: Show message on broken target list
Message-ID: <Z6UoXDqmh3ARH_10@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-29-rrichter@amd.com>
 <20250114111641.00001cf5@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114111641.00001cf5@huawei.com>
X-ClientProxiedBy: FR3P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::10) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CH3PR12MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b844c70-bfd7-4bb5-b365-08dd46f48a75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MfHGaAUFbapjESRYGIcdZeLpu+68t12ELT8ZPtsDwIVpXFGpi7WLWVXn9cy8?=
 =?us-ascii?Q?UeiZ6X5P0os0W1ShCMbxobdAuuUjHD+7NOjbf0sBI4KvQkGnBM2Gdpl6WWl0?=
 =?us-ascii?Q?8sUSsfnnAd+LYJnNZbKHImqfKnpvkNUrhELE8PTfNTOOEdW7DZ+OVgcZB60i?=
 =?us-ascii?Q?4+MIxqKoxex//199IeHEQg88LujsnvSK5Qjp0nBulxWXsGxKDYyBDkT3/R+f?=
 =?us-ascii?Q?znezdIozR//51x9giGA2Z3tnvjQS+L+N9/ZtCTI94w/LFgfw+/WXRSi7L9aX?=
 =?us-ascii?Q?Tfhj6Lf+XU8JC/loO4x90h/jY+UCYm6GVdCYqAghw5jYBAqOjOUEchZ3Cz6P?=
 =?us-ascii?Q?WriiSUG+ERnFEOzWEo9eWntH6xyyzHfKNaj9WXHXAnM0LpqsD6T6SixEIyDr?=
 =?us-ascii?Q?J/RHzM7xa3NagQ2h5z8mp9MFoG5SrryoXNQPyU/nv5Qkcgo1vSep4uxJgORC?=
 =?us-ascii?Q?T65r33nStCPDt8ECETL/u5wjm6pP4ClrcqP8xGkpUX323+1NOVHy3d/tdh+5?=
 =?us-ascii?Q?MN+fKM7pLr6w99UCJo16rwZCtNcY+PGDQNc9AsygPAxiXiH12ZD/YVyWhSTb?=
 =?us-ascii?Q?wlf+5IWzcphQoV0IW9a9LLWFELHXgo2Sc9fy9/Von631pXwj3yryGRjlhCks?=
 =?us-ascii?Q?ZP7KvlItKZyQfBWk38PmikOcnmcDfwZePYjo9x4gxP9ToG36JJGHj0B5eWKA?=
 =?us-ascii?Q?Yqgu0bQrXx5QmCnFedxj2KYD9BmzvLbm6jsFayXxxKeVtCDdhuq5MCboaJI4?=
 =?us-ascii?Q?VeS8i5X0h3D/8w40RHk7vvfa0VQhWBE4rtImdT3USMiLeVb63sASWzt/kbyx?=
 =?us-ascii?Q?IWYlnFew9GaLRhE5ePLx5SZBMB14SHOaY0dfeJde42QHWw7lY7lrOZ9szsRZ?=
 =?us-ascii?Q?MOt1eDCsTGF2nDn8zrembYLMOq300HVV3GW62c7Usoq6dzHfD4r1DttEmuMC?=
 =?us-ascii?Q?btGnrT5eLW99cwAi/8FENsyCOd/Ur55b+PRgVuGI/B8towFo+uikkXJCMiUz?=
 =?us-ascii?Q?5/en8svs9LtcgnwVtrNT1NJklWUMK1P5KsFsI+Tj4x3X5m4SriKfq+DGPl9k?=
 =?us-ascii?Q?xWPCGuyHQitxlDaPc7QS6m2LYfE5gSYhTWg5dYKsDweSJ/mhI1XQK1IfHQO3?=
 =?us-ascii?Q?LxlSjsMdXi4Jj0pIbRVT5AlAVU6XxpgerwS5bw2a2R+hm11SgFQl281FCIeD?=
 =?us-ascii?Q?ktRXoO5g20HLOv08MSMKKbBefWsv/Jk+lf9kT4tVm4JrhkMiYOkrSf6tz2ph?=
 =?us-ascii?Q?tyoWmmwMbIjMlJ0YgfbikyQrWAf738yLKmvK3CrsiBBAzMDB9NScAx+DAeHE?=
 =?us-ascii?Q?TaqXLDqjOXYyp8dvkbTUUYQkz6+I/MmuLjl+RTnc0zrXuyROv9v5KmLoTf+I?=
 =?us-ascii?Q?scdOR615COiczUamGr66EbhyTk0e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zlt6AAfqxZYRhrCXxQraGCIYsAR8+qqQZeoNjutVihr2LjE/UpN61/qdGvjh?=
 =?us-ascii?Q?qCSq4PHg8Pg9QfZcDulLlEo/TS2I4ItNPiddu5C2svauyqhZkDXPUYpFwy7d?=
 =?us-ascii?Q?4IuZqfKusnhv7nrz9O0UP6UgPgX/mpUCn1qfJBWZDyCv6+1ub2WNvfZY4eYJ?=
 =?us-ascii?Q?oxKRH4edNEDDTziuFyk+CJQe9xQ5/XRsIQgwk/sGy0UIoKYgi2c8J5kWPqt4?=
 =?us-ascii?Q?Y+N+1bcl5+xwi9ea2hv5c7TgA1a5H4aR4czrSxP5VERh4F/p3tEqYCxKJqVL?=
 =?us-ascii?Q?duWa2sVjUmLSPY2NS0BeKVzJpfXBOszG3S6nzScIlwxWMQv1RJzcXVz1ZK3V?=
 =?us-ascii?Q?NxzlOtNNRX2P8R0mdbVD4hLGfXm26Gye8npuMI9AAIbgrY6Z5E6MqbPHwrXC?=
 =?us-ascii?Q?osCDs3MXLI3uraLvj3A+0C4dUkxOO2Gt8H74wGYxl+v7MTuBgUxoy+JPAN1z?=
 =?us-ascii?Q?PxKOHPHwo/PverYyV3Osl8dNjoZTHdWj4VApuhTwyALFhy2MSv5zaiSr3ITd?=
 =?us-ascii?Q?fLRZra1VgqCdULQGSkUC1RTlLOEyKA438snSqSuODnEa7qIQemKpKLRehigy?=
 =?us-ascii?Q?ad7FofqNCBqQ4jLEZxF4qvDerBzshZUGW8qY/3mqreHjIbL0EKezAf5MoVkz?=
 =?us-ascii?Q?LrZT82jQZ3NfRXO4gStoXvLK0YqSOfjp//lKayKCmqjZCoKnHwCtwZFuY3lx?=
 =?us-ascii?Q?PRExtHWvyOFwaqUU0jluGuR1KSos57f1yupDboERf0d04bTax8uu76U7N4Ec?=
 =?us-ascii?Q?Xb3McV5li8J2s7lwSWpR+7lr/4F9Thp1ANiHlEVKs9XhEbOteXFJxDWOvEyk?=
 =?us-ascii?Q?w+LkAwtxFmRwJ45f1T5DeprRUai2XI7jF0cyCRzr/77C5sK3rhAZoJ/yzhEV?=
 =?us-ascii?Q?b09fyrbBaAb6NTu2L3djUJlYm0wBm7DX7mOF7i6ZYdOBxRpq40k7XZ7Am5Cr?=
 =?us-ascii?Q?sg1mCBgu2t3/fFGdL/32OZOf7PUKNrBkaVITv75/pPOjtTbHBpAgYSnG2olq?=
 =?us-ascii?Q?UhSpERM35dhMEXK8b03DBLnxkMRuGeS3f+RG7k2u3Q4bXOE0qPtFHDTyqxfX?=
 =?us-ascii?Q?/lYrjGDviCvbqeXjFilDUXohT0/wQGdX7GxwhXPW/XAsf4Iue9ac9XdqkViJ?=
 =?us-ascii?Q?LkhUISNNhs1ZtoWAwzdQacj6cyxEPVZIgcOG08fLPAkIdXfA26r/Ww2xPxdW?=
 =?us-ascii?Q?GolcDD0uyIfQBldfPh9kr0ACX0Kk9CjBonJJCuy81aatYIHeEEDvq7V8a0nA?=
 =?us-ascii?Q?zvM2v4+9+6eGyA+pxENLZXIhFiDieU3yilEPduNBjX7YaKFewUSvJ6Vo4otj?=
 =?us-ascii?Q?xb/KA6A+9cjcM0H+KAAsOVThw94L3twJvN7KV2jxjwuHC4A9TYEISe/Ms0Ny?=
 =?us-ascii?Q?w0R1h6vy+naGhSq6DGOl8QVjb8oY41QcVHTHZTER0dyeQo+5lYPCaFYewAlA?=
 =?us-ascii?Q?t8eeqVal7C8DmFQ/jfCqKawPApBcWpCF7YiwgViyUqXZagOxfyoNqDeUkPd+?=
 =?us-ascii?Q?SGAvwBDLwytmbpRoIzJDe3nbjS0Nd2dZUYJ3Af1jE7RreKF/eLz2W9Mo2OmA?=
 =?us-ascii?Q?UcuOlWZo6L4KIepJQ7BLi8XugoxLu33Ef3GNO0k0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b844c70-bfd7-4bb5-b365-08dd46f48a75
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 21:23:46.6813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNh8/I0aRsOX+xS9w8itlPHUFCupyZ1/yfwJQB5Orf+eqzKlE5J1KWKSYK8PGz03wj4k3LkIHBE5xSNOCVb7LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7498

On 14.01.25 11:16:41, Jonathan Cameron wrote:
> On Tue, 7 Jan 2025 15:10:14 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > Broken target lists are hard to discover as the driver fails at a
> > later initialization stage. Add an error message for this.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/region.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 775450a1a887..2af3b6c14f46 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1870,6 +1870,13 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> >  	}
> >  	put_device(dev);
> >  
> > +	if (rc)
> > +		dev_err(port->uport_dev,
> > +			"failed to find %s:%s in target list of %s\n",
> > +			dev_name(&port->dev),
> > +			dev_name(port->parent_dport->dport_dev),
> > +			dev_name(&cxlsd->cxld.dev));
> > +
> >  	return rc;
> >  }
> This function would benefit from some __free() magic dust.
> Then we could return in the good path in the loop and not need the if (rc)
> check here.

That does not really simplify the code. It would just this one
indentation. On the other side there is a central exit for the code
and we just need only that one put_device(). Plus, I like to have the
'success' code path returning at the end of block.

-Robert

> 
> Otherwise looks fine.
> 
> Jonathan
> 
> >  
> 
