Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D20122
	for <linux-cxl@vger.kernel.org>; Tue,  5 Dec 2023 23:30:05 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8E452227A8E; Wed,  6 Dec 2023 08:30:00 +0100 (CET)
Date: Wed, 6 Dec 2023 08:30:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
	Dmytro Adamenko <dmytro.adamenko@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] kernel/resource: Increment by align value in
 get_free_mem_region()
Message-ID: <20231206073000.GA21084@lst.de>
References: <20231113221324.1118092-1-alison.schofield@intel.com> <656e7a1a79047_45e01294bd@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <656e7a1a79047_45e01294bd@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

