Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9393E28DD1
	for <linux-cxl@vger.kernel.org>; Sat,  7 Oct 2023 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAEABD;
	Sat,  7 Oct 2023 07:46:39 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1E54D30008A16;
	Sat,  7 Oct 2023 16:46:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0FB56323E8; Sat,  7 Oct 2023 16:46:37 +0200 (CEST)
Date: Sat, 7 Oct 2023 16:46:37 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, kvm@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linuxarm@huawei.com,
	David Box <david.e.box@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, "Li, Ming" <ming4.li@intel.com>,
	Zhi Wang <zhi.a.wang@intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Graf <graf@amazon.com>
Subject: Re: [PATCH 05/12] crypto: akcipher - Support more than one signature
 encoding
Message-ID: <20231007144637.GA11302@wunner.de>
References: <cover.1695921656.git.lukas@wunner.de>
 <f4a63091203d09e275c3df983692b630ffca4bca.1695921657.git.lukas@wunner.de>
 <65205ecfaf11a_ae7e729414@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65205ecfaf11a_ae7e729414@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 06, 2023 at 12:23:59PM -0700, Dan Williams wrote:
> Lukas Wunner wrote:
> > Currently only a single default signature encoding is supported per
> > akcipher.
> > 
> > A subsequent commit will allow a second encoding for ecdsa, namely P1363
> > alternatively to X9.62.
> > 
> > To accommodate for that, amend struct akcipher_request and struct
> > crypto_akcipher_sync_data to store the desired signature encoding for
> > verify and sign ops.
> > 
> > Amend akcipher_request_set_crypt(), crypto_sig_verify() and
> > crypto_sig_sign() with an additional parameter which specifies the
> > desired signature encoding.  Adjust all callers.
> 
> I can only review this in generic terms, I just wonder why this decided to
> pass a string rather than an enum?

The keyctl user space interface passes strings and crypto/algapi.c
likewise uses strings to identify algorithms.  It appears to be the
commonly used style in the crypto and keys subsystems.  In particular,
security/keys/keyctl_pkey.c already uses strings for the signature
encoding.

I just tried to blend in with the existing code.
Happy to make adjustments if Herbert or David say so.

Thanks,

Lukas
