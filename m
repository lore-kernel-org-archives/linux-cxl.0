Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833D612E6D
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F6018B
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 13:44:25 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5PrK2L5Hz6K7G3;
	Thu, 12 Oct 2023 04:44:01 +0800 (CST)
Received: from localhost (10.126.175.8) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 21:44:22 +0100
Date: Wed, 11 Oct 2023 21:44:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v3 07/10] cxl/memdev: Fix sanitize vs decoder setup
 locking
Message-ID: <20231011214420.00005b84@Huawei.com>
In-Reply-To: <652448294503e_ae7e7294f5@dwillia2-xfh.jf.intel.com.notmuch>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
	<169657719974.1491153.15276451196916291864.stgit@dwillia2-xfh.jf.intel.com>
	<20231009174624.00000bd7@Huawei.com>
	<652448294503e_ae7e7294f5@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.175.8]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 9 Oct 2023 11:36:25 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Fri, 06 Oct 2023 00:26:39 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > The sanitize operation is destructive and the expectation is that the
> > > device is unmapped while in progress. The current implementation does a
> > > lockless check for decoders being active, but then does nothing to
> > > prevent decoders from racing to be committed. Introduce state tracking
> > > to resolve this race.
> > > 
> > > This incidentally cleans up unpriveleged userspace from triggering mmio
> > > read cycles by spinning on reading the 'securiry/state' attribute. Which  
> > 
> > Needs a spell check.  security  
> 
> Fixed.
> 

Given you answered Ira's question which I was waiting for,
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
