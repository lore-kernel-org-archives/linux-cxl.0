Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D89B2940B
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Fj5u6Rk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocW6Qh0AGMSSdUkYTIrFiJnAPr8dC4bHjmM+wPto8U55TlxL/TXsT2QabJlUBsW5+ehxfLnbeclvuDd9dQT1GTyrWJT1ioHb9Z8rp0mluRlsCqkii2lLnz9qQ9gCZhIpwmoKP+bBeMrZTNW24lrok7DFwmZ+OgehPFeO7HUevA68PNaozgeGG391M6+7DG9a8THr8GFqDMW31OqDMvyJZX2tHSKCMpYoMBKRFgX4t18aD1zl7AVMCyMiiXHxxcLcNLA+1KcJ2Pnwd8CfDiQo+YHDLbajVHJfe9hP0aPT1hAPiiTfjpKnH1lOfOgPC05zad61+iSPDXP76MiUrH1ndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyfxdCpUflRmDEbuA2pTKlmYIW5+6qwroMkZgsdxU0I=;
 b=kYKBFEIPhBOzpmYHYH91/QARwLdSsR4diT7glt/ICPci7f8QxC0GXN/40K+bDr6iHEDisg5ONj3ga2dldcjhuaT9EUDrWitTdpdtkpr7eD0tlLKG/g0ILCGOTb9PYl3fgsgcrisdtQ3wMgZ/cTn4h3S4b2kuK4wQZFv3QVRgR0SV6MQ3gAZ8AsOJO28kW6CG8oAoYgrXHOaWjLFIKJ9bVjDzPcRtDwme/mc9skQUIlv9+xZklgYEOWeKwi2zwjcAEhZoLPNx+BPSF8xi+SZb4c42uDrRinRFdy4aBSIPpDMIL/h1tsRrbv0iZNMvfuRyYXyEMZMy9WyJhgeygi5+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyfxdCpUflRmDEbuA2pTKlmYIW5+6qwroMkZgsdxU0I=;
 b=4Fj5u6Rk2yoU8Vody/FDYn9my8LP/BO9g55olmc1JNgYc0iBYezwkKxV6FAZD2oXGGzyhOigtaOVgh8dc9Zg7o7Fguk7j1oNZq7YZ8i0NmY5u0GIpDJBwSw1Nr9fFnTINgc+aHS4LOYhd0jIx4xyKLm2nzzcvkROdwv1BiIVgls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by BN9PR12MB5116.namprd12.prod.outlook.com (2603:10b6:408:119::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 11:57:22 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::e46e:7c32:7556:fae1]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::e46e:7c32:7556:fae1%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 11:57:22 +0000
Date: Mon, 8 Jan 2024 12:57:16 +0100
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, dave@stgolabs.net
Subject: Re: [PATCH] cxl: Clarify root_port cleanup routine for
 cxl_qos_class_verify()
Message-ID: <ZZvjHJFELV-tiasa@rric.localdomain>
References: <170438448564.3436708.17525645430052031684.stgit@djiang5-mobl3>
 <65970c97b2b6c_8dc68294ca@dwillia2-xfh.jf.intel.com.notmuch>
 <20240108114557.00000efc@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108114557.00000efc@Huawei.com>
X-ClientProxiedBy: FR0P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::6) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|BN9PR12MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e13e874-cd88-4322-c700-08dc1040f920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xEPGYg7hIo/pDdiuWsvQVzCojoecTOjjyToRi+p2RtqrzkZKfnHMzE0C9u8RXZW7yodzzVwQP76IG+ZcoCD2XUeTQhuDub/cz1FTjEE9GE0hZQAI3WtVmIyAayLlFv4H3SgU/JCopSRX7NP8faZNnMtByc0Y3GcydhXQC4Irt//F6k+FFrKNjvB0rO2AORS9GzGuzMB+vCQJ1mQAKBN0PNdTUaj3FyWHopuhSmgSx6mGH2BR7qnEFr5bFUPEQjXMrpOX9kYTay6J2E3TjHUgZZ6pI4pyTNCFTm7Lf21ZtH8DBQb09CoCuZ0uvLqOccqBbZDFpiRX0krG04/NpUemUPRR3z0a/uouSHSid984YE0YSt5jP3t5bajH2B6SY4t1LICnQJFbeIK7v1tdk3BMEjwPd0co/lgw5v2rKs8Xyw+6eV/agYRJWiAs6OQfEB2QAo3WJXmlu4o4P2IJeRgFDDqAPwH5EVZEIP+lh/vEZMcOKiSvXus3e1KDzpmNEbaGtiVnszzd+erGuFSYInz3aexT6RB+lY9+kfwty+cjRr5QYjSUT5fUOh+JUxRySfX2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(396003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(38100700002)(5660300002)(6666004)(478600001)(6916009)(2906002)(4326008)(53546011)(26005)(8676002)(8936002)(316002)(6506007)(9686003)(54906003)(6512007)(41300700001)(6486002)(83380400001)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0nPPbB64G05EtLNgtSQHlVl2G1+sfkibK2zZgaf1Dah18YVonSTCfc6zf16Q?=
 =?us-ascii?Q?FKRGpaWl0BWeN/jjYcNYn8c//v7IXQ1RtndTS3okb/vkrCfsbeGVsNXIYFHy?=
 =?us-ascii?Q?gY1IYIkZddIV8hdekuwTBAFRozQ2ZKfiQ28iW/gcHy0WsAQnN9nW+uZ67B1L?=
 =?us-ascii?Q?QKoTnVMS9cgA/di2GvtN23ErK9RF9JXIXCP8lsmlJosFkDlBlIZx7wLTAOMv?=
 =?us-ascii?Q?HZb4qOFRGngC4T8KiSJdUaYxKoSDPwwdAH1XAWC9RTTjtvteKLj5gnpUaoHv?=
 =?us-ascii?Q?4jdabYCvhbx0yWXX2nddtqayo5Mp+trnPvG9YPyfRL9oa3FaiYuzw5NJEX1/?=
 =?us-ascii?Q?/5TamuKuz+JE9q6ViUfAVqnjUq0q9tZBFbdoIYMUbIE1DMYPYlBMGXGZ3WMB?=
 =?us-ascii?Q?2+9glmYZ9RzJmlpbGPc0kfOs0GxIAJGdWUT/JwCGrjdFnqcKKSBlaTsG8vYs?=
 =?us-ascii?Q?PyfSj4JLqXhUNCoL1hLsWrrJj0Wch9T/B/fAQRnnZQL4jC+noZZVLyNHCO8M?=
 =?us-ascii?Q?LmIrhNzyo9oXkYXu1DvVY4WLmKNgX1UZMgf0hrWXhC3Yz2VfRbf3zUHf6MxX?=
 =?us-ascii?Q?w8qpvjtQQNXHXeQ9K/svULi2bS3phhuhRqDeycY9SxAf/5O8IwWYxQXJaHTv?=
 =?us-ascii?Q?XNoREgavygBuPX8DHs8Xs6KTPu+hrcA3w05Tu1/V+8MiEFSKAUQJBHYKk6Cy?=
 =?us-ascii?Q?i/Zm3dBtZXCkepKnLtWC12wIAMjWLwZf5p28H56iEtqQta1F5Lb84G04ZGnf?=
 =?us-ascii?Q?Hz1JtPvZ0KpFMwHHsg+JAH/jWtXFjlNp8g6pwnQzGgvZEFY3YtnD4Wm0pqTf?=
 =?us-ascii?Q?1Z2AOax3ql+Ko5fwhC/7e5ptF/lDEe2DxM0swiL6TQEetS8pNe4LQhfm6bhq?=
 =?us-ascii?Q?S0EDoYdUmlqT0f7uI4V6vAxSh3cUDdNgW7Cw51hOBAw6WEjkWKsFrEwdMR1O?=
 =?us-ascii?Q?IHJ8/law3KVavPPZOG2VxGRg2uwpXEWJJbiMIL2FzW6Hbt6XbXrsJ02b2OfZ?=
 =?us-ascii?Q?eQpGxHXS1PoOg0YqRa55jkk/7eEJxHPc4cLa71pXHK2xcylOOGUwk1y5Vlx/?=
 =?us-ascii?Q?QGZgz1+zK1fKCnzTqMhmph6P1nOc+9jq9Lvi+Bx/Qrx+gKEkYbg1zRQC/cjl?=
 =?us-ascii?Q?0hTbNXApWFla7XLLjBqCGfRQ5rhEM5Zf1t+ehCIu+EKAqP6UPX9ABMkmF68u?=
 =?us-ascii?Q?+ID/5TFptDj74Zi+xnsDmuZ13PBrSWjOGZGQaEW5GTVzPDqW1+lnmE8PMNwc?=
 =?us-ascii?Q?4NHGNY4N4cLW8H48YqJCTTE0JjGbuPyRhS5cSw39XI2zs6P0ElpXSCWKvTGq?=
 =?us-ascii?Q?i1iVSQbwRlIhnJuGNPygeg46uMaY8zQQrNUTuZd2Hq8GfDnXvFg/GrlDn9Rm?=
 =?us-ascii?Q?ppgyqx1TC2V1L8yCO2TKFogTF88oSu1ZuIc1LGjGX2G8Kia/+3JMkgzT+0wr?=
 =?us-ascii?Q?b2fiBtdw1j2PTX0qJb/JtjT2Tu78/XQxNk3ztjFqbp79KwzFrxkFcOhe2BPB?=
 =?us-ascii?Q?Zk8OReNjipz/wUEuYnvMtgRc61T32+rd4GLS5KlDwDh0epZDd6+HIeIbd0m8?=
 =?us-ascii?Q?7+DQRBFS1Gm8xzRH57PivIMLw/xsYHgjrevRR1vU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e13e874-cd88-4322-c700-08dc1040f920
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:57:22.4660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEYVPBv09jtifT1r5htJj9F+fiilM+zayChkzGq8AP9/PYrBTUMWHEB7pqNiJil70RwPhUQpEY/K/aA+WljijQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5116

On 08.01.24 11:45:57, Jonathan Cameron wrote:
> On Thu, 4 Jan 2024 11:52:55 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Dave Jiang wrote:
> > > The current __free() call for root_port in cxl_qos_class_verify() depends
> > > on 'struct device' to be the first member of 'struct cxl_port' and calls
> > > put_device() directly with the root_port pointer passed in. Add a helper
> > > function put_cxl_port() to handle the put_device() properly and avoid
> > > future issues if the 'struct device' member moves.
> > > 
> > > Suggested-by: Robert Richter <rrichter@amd.com>
> > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > > ---
> > >  drivers/cxl/core/cdat.c |   12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > > index cd84d87f597a..d6e64570032f 100644
> > > --- a/drivers/cxl/core/cdat.c
> > > +++ b/drivers/cxl/core/cdat.c
> > > @@ -345,11 +345,21 @@ static void discard_dpa_perf(struct list_head *list)
> > >  }
> > >  DEFINE_FREE(dpa_perf, struct list_head *, if (!list_empty(_T)) discard_dpa_perf(_T))
> > >  
> > > +static void put_cxl_port(struct cxl_port *port)
> > > +{
> > > +	if (!port)
> > > +		return;
> > > +
> > > +	put_device(&port->dev);
> > > +}
> > > +
> > > +DEFINE_FREE(cxl_port, struct cxl_port *, put_cxl_port(_T))  
> > 
> > I don't think there are other cases where a port reference is acquired
> > at runtime, so this should be root specific, i.e. put_cxl_root().
> > 
> > This also merits a NULL check to skip calling put_cxl_root() if the
> > pointer is already NULL:
> > 
> > 	DEFINE_FREE(put_cxl_root, struct cxl_port *, if (_T) put_cxl_root(_T))
> > 
> > ...for example if someone used no_free_ptr() to return the found root
> > port.
> Hi Dan,
> 
> Sorry for late reply - been distracted and only now playing catch up.
> 
> 
> I'm curious on this mostly because I got similar review feedback on another
> case without the if (_T) and conversely yet another review asking me
> to drop it as pointless (totally unrelated bits of the kernel ;)
> Why do we care given put_cxl_port() has that check? It's clearly harmless
> but also at first glance pointless. 

There is some description in include/linux/cleanup.h:

 * NOTE: the DEFINE_FREE()'s @free expression includes a NULL test even though                                                                                                          
 * kfree() is fine to be called with a NULL value. This is on purpose. This way                                                                                                          
 * the compiler sees the end of our alloc_obj() function as:                                                                                                          
 *                                                                                                          
 *      tmp = p;                                                                                                          
 *      p = NULL;                                                                                                          
 *      if (p)                                                                                                          
 *              kfree(p);                                                                                                          
 *      return tmp;                                                                                                          
 *                                                                                                          
 * And through the magic of value-propagation and dead-code-elimination, it                                                                                                          
 * eliminates the actual cleanup call and compiles into:                                                                                                          
 *                                                                                                          
 *      return p;                                                                                                          
 *                                                                                                          
 * Without the NULL test it turns into a mess and the compiler can't help us.                                                                                                          

So afaiu if the check is local the compiler optimizes to not call the
function at all when using return_ptr(p) (end maybe if NULL
preinitialized).

-Robert
