Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817F81BF33C;
	Tue,  6 Aug 2024 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941668; cv=fail; b=jdS6XCdXiR19UdmFLT3MQOb0BjSWSjIt7QtR/B7ZQJ6esWT7HsxNPUO6LUDCf08WcAJqrfhv8jSWgaXyPlHgwkVdfDiNH/8AXH8lUufoPUdf5ElOKe1qbxPO0qac41YksMFfIsS9z0xyPOFDJ/HBvFoUPBhAnQWSjm7IU1bhcwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941668; c=relaxed/simple;
	bh=4qKKMJpuwAYqhTcXDpRnC8GtIZkaZzHvzCE7neyGgy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=miecwpVPRQOmI4fdAYWkxf21wKZUJ3nay2EyXNSirXQelg/vikaYTTqOeLQ1J5ePfR5SHUqJDkm77rzPlXse2JzGyrq6eROdnkoA0bDB6JkF/SxreLXh7ELJa5lSzQNLdoLRXHFd8+W3nYkLT01FGaUAhE4EFQTinSw9qlgGWEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4ZFDQy+7; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4ZFDQy+7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWXe0dHNbm6agSNMp5TXqUHQJEoOMgLcACgjUlfBmnBgRgwg1B1xoqxBaukM333pd4OuJfZ8coLuqh6Uft5AfTynv2DYS0Y7/rYQOIEu6zE27u6Lxebs9IKTCUtfFLB5YYfCwgOscPCSPLFG+AKKgANwT6U6lhKrNzXVKo8PCxzhY78V+y1Er92+y/ZTPA1CqDf7c93IEacrptCStQLheeun+Jikzb2zT7pn/LkA3lOOKKgOQL6fLOZ21GfYeUWnYYQNpvMHR5QrsTo1lAk3LkQleGodzZwCmHts6LZQdPXrgczlDEoqmHs2oyFdAAdAKAbuvIwHkiZBpp3tfycrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlNIad71xA2eCs+SD/zYvk68R+C8SyzXbBXoFPPUGds=;
 b=nTx1OU8sYivwKiFCIKh/qJRB2FiQ3I71kWG/aUC8QSDlKegX/Bjf+Ti+8wVqzaRvdiIHj05eadOMu/lkb84NMp/EijqcEHpZEdg0+DmKcS6TE53fDHJ/n4sEtUHWwfBW+O9KwJMolck8eXcCdCSn9ul4+xLoSmKxS5KnO8VjdEVcsHh8rKwYDzgAOchV0Sm2c0uo3QhkBoe5ZVWC2Yvv2Bab5TgtXdN2HcfK1De0TeM2uMYUSVYFH4BG0FuhOhYkOjjEPJ78jAMi920Si0dQM7BBT+Y9jmVWwz7kAZjacMsfIFZL3Wo2hmM2YE3DR7mJ0xBtU1TsZjjvzXjK9raNgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlNIad71xA2eCs+SD/zYvk68R+C8SyzXbBXoFPPUGds=;
 b=4ZFDQy+7MxJ9GNjLvcHEYIc0y6ayHcwCVhswDC78LCAWt4shqK9yX4YCZXsexWYNbykqPHpV4Wpfx5DeRIMuL+ZlIgJwVAPvGYG7aSbF3vhyaR7slVy4Y9i5aV3hp/D2iJXGZqBW83t8rYRLNgU8R2xp2bY8DSDBDUodY5NoDyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Tue, 6 Aug
 2024 10:54:23 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.7807.026; Tue, 6 Aug 2024
 10:54:23 +0000
Date: Tue, 6 Aug 2024 12:54:36 +0200
From: Robert Richter <rrichter@amd.com>
To: Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Address translation for HDM decoding
Message-ID: <ZrIA7Bttr3fVXl-0@rric.localdomain>
References: <20240701174754.967954-1-rrichter@amd.com>
 <ZqLK4CpSg4PfAdGx@PC2K9PVX.TheFacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqLK4CpSg4PfAdGx@PC2K9PVX.TheFacebook.com>
X-ClientProxiedBy: FR3P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::20) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: b4bba6df-546a-42e4-62fe-08dcb60621e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LxDpQu5UK9KiN3jElZc0fQMpCH4OYA5pAAzYqQ5nfHtnRIlPCynKkwKWmVxa?=
 =?us-ascii?Q?e5+dNYNzuIhlAw2nm0U74mIwD8oO/v3WwYKyw6iBmhv8QcppyDgvRv7ACQrx?=
 =?us-ascii?Q?dI1QKsBR8/xKvNoZwa6vLIMTp/cETeM/EZuahoH3tjEz0zRjbuI97v83aEYD?=
 =?us-ascii?Q?7vF2pGyn1AaEWmezz2ktXY+dFhyD4JnbgmnxhkuXSIsJD2O3OLWhm3VN/h+h?=
 =?us-ascii?Q?B9Np1v1fmpcwQU7kHJatv+pANHlJ3HDd2PgUzFnN9Sp5Cdp/E+zjL/THtCAP?=
 =?us-ascii?Q?1nf1enUX3975o+7SGyAudxoX2edW8DsOR+jKXLJOi8J7cnaShut7xHw8pxQ/?=
 =?us-ascii?Q?j6+Auq4102kqAyzueZgayCi3Lx6YW0siTSLnBQ7USG2exKnvxBP3BroZIq/H?=
 =?us-ascii?Q?FsDTpqQzsYg1v4jMLjtWvWD68AcevH1omgAJ/3gEQJC6+0ZjtLl/GRasSeTp?=
 =?us-ascii?Q?/V6fAygK8a1HeEz77hNVdzQqJcjFdFZ2eWiSoIViEZ0uObBbKZh554mrv/wq?=
 =?us-ascii?Q?GXYRmqsdfmMy+rOUTmxuwt6LRWgBnfQ8nHyTXH+HdQ+eZdTdWT2pTWtmWuEH?=
 =?us-ascii?Q?UQz19VBYcvnQp97q/oQyTbNOlTGhlAWDMkpwE+2JiVKHFhQigWqIVqwAQBgL?=
 =?us-ascii?Q?rg5pUuAuflAdFRUWpgXdg+D8OgiGYXjalraASkbmvS8Vn0wE58tY/ut/LjnU?=
 =?us-ascii?Q?7XaZw8NPcxPM7sWcdt/XktTD5AtvREeMdClYQ17LKzLC0VU4RWHyRkC/hffP?=
 =?us-ascii?Q?ZDuQJqnG2tr/9hGoZ2g2oXcHhPYowKhSod3fRxPEY7yvcDY5rZgOnDirv/LU?=
 =?us-ascii?Q?0a5UyhuRtSG/CFBw4KGAyBQDvz/z68jea0ga65VYmLHrVrZDFm+sgyfCKe46?=
 =?us-ascii?Q?1ekGd6kDDMxlZUpMN1Oc89bWZE2Zxy7qWf0FSHfJmEQsDL2m7c5bVtYIJzTu?=
 =?us-ascii?Q?rv7lSPAMh5pmzs56llssr1OH/guHYf+w39kWm05909dzM5xTwFpDThkDKQ0f?=
 =?us-ascii?Q?sp06Hw7q2xycq2RAFog9rQ/4OCD4m4x9iyePd2eZ4+i6Ez5YnCXuljb/Flqe?=
 =?us-ascii?Q?sFoRBfGUoqE9wCrgooRuSSI+gzB2L2lMtrAUwOCFfxdN75DlJO3nHtioAo8E?=
 =?us-ascii?Q?kji4oGQ1lQwmfQ6zvlZ0FsbCm+CDzyDB6fMN08UcPlkdh8TDpcvJCGpK0wrF?=
 =?us-ascii?Q?CtQQW75W4uEOpbQ/V6JFQTYEhYkjTX9j45frqqkBG7wlPfnYdvRc3X6v1Hj3?=
 =?us-ascii?Q?7dMI441ptCrTngBEXTGlIZ6jnohi2d5Mey2wmGSb+7x/HahZhG1GVM/UtExW?=
 =?us-ascii?Q?EV5YUb3yGJxI6tbY+YbF47/hw25AfVFewYUWFr4lkg5x0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EBkNCNWj6zcZKUIXh3OHn8lIfoXwMVjryAWX9hejiSIpA2fVeGbh9PFxg8h2?=
 =?us-ascii?Q?k3iWe1KD6YbPD/3pRXRsL8si8/ypHNzcIsC+7Fj3je3t1PGGmd1VvY3ZM6qk?=
 =?us-ascii?Q?SDyinrOIF+BYr/QhO1UlV++Ed2TMhMEk93wntPaONoMIe9bFN1mP9b7ZaZe2?=
 =?us-ascii?Q?M2DbjVphlUhguWdbV1xDfCDJHL0l0FlC4z6HfuROyML5uBWtNPAyqGaCNygQ?=
 =?us-ascii?Q?388aEThLp+eQyL2wDG+Px+rnR2L9TEJDGTLjyhCYNvp2xh6E0JUvaGiKARig?=
 =?us-ascii?Q?Bm2LIx/4UE7e6lbNBuMpGVgwy2nLVpWZnWSQ/MuRqjE7Fc9vqo91FCF6ZrR9?=
 =?us-ascii?Q?4HM4hVOmVTigd9/tZIAeKXpULBarrjLvipivw/eRmWzf9XYVRXYmVvNpchNm?=
 =?us-ascii?Q?zxFBOVSYGGahYeciQxHiRGCtvItiubA3nbko81RnJQgVS/+KNp/HE1j4Tegt?=
 =?us-ascii?Q?ZZl/dpIRQOiAPf4PpF/dmdg7mYhSN6QHvPaO9xDSGf6A+2ZuVV9RXw2LgLqE?=
 =?us-ascii?Q?5zDKEfyzE8417UMrtRrGYboylRdzzs1ioOLWC7hjmaVO/roMxd7BnjL4fGAR?=
 =?us-ascii?Q?1utq8LywiAtlFt1cCj1BbQa6yhGz+nSkRCwhGa9lc/rdmU1QjZ8p+KTs1Do4?=
 =?us-ascii?Q?W9kxezCmq9bAJXssjglh9FW5t/WPUXqrNG9+vGvK21+p4N4ORLf/BnoypWFE?=
 =?us-ascii?Q?I8abYU02twfykuudS35ymNWPhDLXE30gHBo8P6UC/NNUYjSbl3mCUEvWaAhu?=
 =?us-ascii?Q?ySh2NROIjmaNjf/AcGKok9DVc7sQN8GUsYnn80bclr513MFDasyjEnDdBYv9?=
 =?us-ascii?Q?SG4vLIZJzybH0RRzhXWhcq1NbI3KeaFn5iSndn+K1Yz4DzxHQ1Pi//qCDImY?=
 =?us-ascii?Q?GtUGIV1rIeQ7hDYxf4WSuh+VfLABdWpl6X0USKrDjbXOcKRZOe9Og3u2NGCx?=
 =?us-ascii?Q?Hgdnok5NCT0tZTZFZK2JfubKGul1yMObbY3gMuTRjd9iJQrzdGXwthyJON3j?=
 =?us-ascii?Q?O4h0FdOZ9Rae6p6XevOy5a40EylkD46tsBlnRKa6sT34pNWD4yKg8QDQqo3Y?=
 =?us-ascii?Q?htC2GImpDWy9sfiI4dG8AAuONOfQ4ESE+AqaxoGd7kRcpD1dBT7l5ghLzPWq?=
 =?us-ascii?Q?GwgS6r/LaxJAMzBq3Q8YNcEJB7JkT4uvGDBHlTYAe1qVtnobHSa9ccZvwb/M?=
 =?us-ascii?Q?W9HMh/On2WTjw1Gq8c0Y3MNHs25WauRfcq6MNaiRcrV9slDMpUtY0nMLHyA5?=
 =?us-ascii?Q?4toUZqWQ3ETcgXXiUaHu6LVe5mnpldRP275sSOo0vDIoE9m8V8ZHYPCg4Ll2?=
 =?us-ascii?Q?+HKwlGDwKz89yiBMxJ/d91UQ9zrDbZOPCQMFYTHgVxmMQNHNLuPjEz9S3VNN?=
 =?us-ascii?Q?XfT4MDG2hFxKTATfMKiPS4PAvTZJrR+tIBs7rF4HOTggOtc7/leZfybr7tVb?=
 =?us-ascii?Q?WlelY4gzZcImza5fUtplRYUYcQTkpT8+8uxNVvUSDuD7mFTVGWdNhyPijwFd?=
 =?us-ascii?Q?Nfc+wuqwM6ZIRjrv2GtSOZFOweZ+sSVuI6guWu1RHF2XJnTLSu8r/ufYDLqo?=
 =?us-ascii?Q?EuWg9nhG3nlm6Ra9GYcmolvJESzg9HXl2/eKV0VU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bba6df-546a-42e4-62fe-08dcb60621e3
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 10:54:23.5506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FZ8F37MqqJK4v31YL1uTW3kYIFqMhu8jkjjlbnkXtl7yq4dew0VPdGQYLUvtfeqOeBNDMRESSre5fSP3U5ZDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319

On 25.07.24 18:00:00, Gregory Price wrote:
> On Mon, Jul 01, 2024 at 07:47:48PM +0200, Robert Richter wrote:
> > Default expectation of Linux is that HPA == SPA, which means that
> > hardware addresses in the decoders are the same as the kernel sees
> > them. However, there are platforms where this is not the case and an
> > address translation between decoder's (HPA) and the system's physical
> > addresses (SPA) is needed.
> > 
> > This series implements address translation for HDM decoding. The
> > implementation follows the rule that the representation of hardware
> > address ranges in the kernel are all SPA. If decoder registers (HDM
> > decoder cap or register range) are not SPA, a base offset must be
> > applied. Translation happens when accessing the registers back and
> > forth. After a read access an address will be converted to SPA and
> > before a write access the programmed address is translated from an
> > SPA. The decoder register access can be easily encapsulated by address
> > translation and thus there are only a few places where translation is
> > needed and the code must be changed. This is implemented in patch #2,
> > patch #1 is a prerequisite.
> > 
> > Address translation is restricted to platforms that need it. As such a
> > platform check is needed and a flag is introduced for this (patch #3).
> > 
> > For address translation the base offset must be determined for the
> > memory domain. Depending on the platform there are various options for
> > this. The address range in the CEDT's CFWMS entry of the CXL host
> > bridge can be used to determine the decoder's base address (patch
> > #4). This is enabled for AMD Zen4 platforms (patch #5).
> > 
> > Changelog:
> > 
> > v2:
> >  * Fixed build error for other archs [kbot]
> > 
> 
> Hi Robert,
> 
> I'm looking to test this patch series but saw you were looking at
> reworking a portion of it.  Just wanted to inquire as to whether
> you think I should wait for a v3 given this is a few weeks old now.

Yes, please wait with it.

Thanks,

-Robert
